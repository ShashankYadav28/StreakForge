//
//  HabitViewModel.swift
//  StreakForge
//
//  Created by Shashank Yadav on 04/03/26.
//

import Foundation
import Combine

class HabitViewModel:ObservableObject {
    
    let habitKey = "savedHabis"
    let logKey = "savedHabitsLogs"
    
    init() {
        loadHabits()
        loadLogs()
    }
    @Published var habits:[Habit] = []
    
    // habit log is the collection of the progress ovew teh tinmeline
    @Published var habitLogs:[HabitLog] = []
    
    func addHabit(habit:Habit) {
        habits.append(habit)
        saveHabit()
    }
    
    func deleteHabit(habitID:Habit.ID) {
        habits.removeAll {
            $0.id == habitID
        }
        habitLogs.removeAll {
            $0.habitID == habitID
        }
        saveHabit()
        saveLogs()
        
    }
    func goal(habit:Habit)->(Int){
        
         var goal:Int
        switch habit.frequency {
        case .daily(let goalsPerday):
            goal = goalsPerday
        case .weekly(let goalsPerWeek):
            goal = goalsPerWeek
        case .custom(let days, let goalPerDay):
            goal = goalPerDay
        }
        return goal
        
    }
    
    func logCompletion(habitID:Habit.ID) {
        
        let todaysDate = Date()
        let date  = Calendar.current.startOfDay(for: todaysDate)
        let  index = habitLogs.firstIndex { habitlog in
            habitlog.habitID == habitID &&
            Calendar.current.isDate(habitlog.date, inSameDayAs: date)
        }
        let habit = habits.first {
            $0.id == habitID
        }
        guard let habit = habit else {
            return
        }
        
        if let index = index {
           
            var result  = goal(habit: habit)
            
//            var goal:Int
//            switch habit.frequency {
//                
//            case .daily(goalsPerday: let goalsPerday):
//                goal  = goalsPerday
//            case .weekly(goalsPerWeek: let goalsPerWeek):
//                goal = goalsPerWeek
//            case .custom(days: let days, goalPerDay: let goalPerDay):
//                goal = goalPerDay
//            }
           
            
            if habitLogs[index].count<result{
                habitLogs[index].count+=1
            }
            
        }
        else {
            let result  = HabitLog(habitID: habitID, count: 1, date: todaysDate)
            habitLogs.append(result)
        }
        saveLogs()
       
    }
    
    func todaysCompletion(habitID:Habit.ID) ->(Int) {
        let todaysDate = Date()
        let log  = habitLogs.first {
            $0.habitID == habitID
            && Calendar.current.isDate($0.date, inSameDayAs: todaysDate)
        }
        if let log = log {
            return log.count
        }else {
            return 0
        }
        
    }
    
    func streakCompletion (habitID:Habit.ID) ->Int {
        
        let habitlogsForHabit = habitLogs.filter { habit in
            habit.habitID == habitID
        }.sorted { first, second in
            first.date>second.date
        }
        let foundHabit  = habits.first {
            $0.id == habitID
        }
        
        guard let habit  = foundHabit else {
            return 0
        }
        var streak:Int = 0
        let habitGoal = goal(habit: habit)
        let today  = Date()
        for log in habitlogsForHabit {
            let isToday = Calendar.current.isDate(log.date, inSameDayAs: today)
            if isToday && log.count<habitGoal {
                continue
            }
        
            if log.count>=habitGoal {
                streak+=1
            }
            else {
                break
            }
        }
        return streak
        
    }
   
    func progressCompletion(habitID:Habit.ID)->Double{
        
        let  habit = habits.first {
            $0.id == habitID
        }
        guard let habit =  habit else {
            return 0.0
        }
        
        let goalOfHabit = goal(habit: habit)
        let todaysCompletion  = todaysCompletion(habitID: habitID)
        
        let result:Double
        guard  goalOfHabit != 0  else {
            return 0.0
            
        }
        result  = Double(todaysCompletion)/Double(goalOfHabit)
        return min(result,1.0)
 
    }
    
    func iscompletedToday(habitID:Habit.ID)-> Bool{
        let habit = habits.first {
            $0.id == habitID
        }
        guard let habit  = habit else {
            return false
        }
        let completion = todaysCompletion(habitID: habitID)
        let goalOfHabit =  goal(habit: habit)
        return completion>=goalOfHabit
        
    }
    
    func remainingCompletion(habitId:Habit.ID)->Double {
        let habit  = habits.first { habit in
            habit.id == habitId
        }
        guard let habit =  habit else  {
            return 0.0
        }
        let todaysCompletion = todaysCompletion(habitID: habitId)
        let goalCompletion = goal(habit: habit)
        
        let remaining = goalCompletion - todaysCompletion
        return max(Double(remaining),0.0)
    }
    
    func saveHabit()  {
        do {
            let data = try JSONEncoder().encode(habits)
            UserDefaults.standard.set(data, forKey: habitKey)
        } catch {
            print(error.localizedDescription)
        }
      
    }
    func loadHabits() {
        let data  = UserDefaults.standard.data(forKey: habitKey)
        guard let data  = data  else {
            return
        }
        do {
            let decodedData = try JSONDecoder().decode([Habit].self, from: data)
            habits = decodedData
        } catch  {
            print(error.localizedDescription)
            
        }
        

    }
    
    func saveLogs() {
        do {
            let data = try JSONEncoder().encode(habitLogs)
            UserDefaults.standard.set(data, forKey: logKey)
        }
        catch  {
            print(error.localizedDescription)
        }
        
    }
    
    func loadLogs() {
        
        let data = UserDefaults.standard.data(forKey: logKey)
        guard let data = data else {
            return
        }
        
        do  {
            
            let decodedData = try JSONDecoder().decode([HabitLog].self, from: data)
            habitLogs = decodedData
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

