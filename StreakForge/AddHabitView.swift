//
//  AddHabitScreen.swift
//  StreakForge
//
//  Created by Shashank Yadav on 13/03/26.
//

import SwiftUI

struct AddHabitView: View {
//    @ObservedObject var habitVIewModel:HabitViewModel
    @State var title:String = ""
    @State var selectionFrequency:FrequencyType = .daily
    @State var selectedDays: Set<Habit.Weekday> = []
    @State var dailyGoal = 1
    @State var weeklyGoal = 1
    @State var customGoal = 1
    var onSave:(Habit) -> Void
    
    // it work like basiclly calling the function throught the envirnment that can dismiss the view and later we can call the function
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form {
                Section("Habit Name "){
                    TextField("Enter Habit Name...", text: $title)
                    
                    
                }
                Section("Picker"){
                    Picker("Frequency Section", selection: $selectionFrequency) {
                        ForEach(FrequencyType.allCases) { data in
                            Text(data.rawValue.capitalized)
                                .tag(data)
                        }
                    }
                    
                    .pickerStyle(.segmented)
                }
                
                switch selectionFrequency {
                case .daily:
                    Section("Goal Per Day"){
                        Stepper(value:$dailyGoal,in: 1...20) {
                            Text("Daily Goal : \(dailyGoal)")
                        }
                        
                    }
                case .weekly:
                    Section("Goal Per Week"){
                        Stepper(value:$weeklyGoal,in: 1...50) {
                            Text("Weekly Goal : \(weeklyGoal)")
                        }
                        
                    }
                    
                case .custom:
                    Section("Select days") {
                        ForEach(Habit.Weekday.allCases) { data in
                            Toggle(data.rawValue.capitalized, isOn: Binding(get: {
                                selectedDays.contains(data)
                            }, set: { newValue in
                                if newValue  {
                                    selectedDays.insert(data)
                                }
                                else {
                                    selectedDays.remove(data)
                                }
                            }))
                            
                        }
                    }
                    Section("Goal Per Day"){
                        Stepper(value:$customGoal,in: 1...20) {
                            Text("Goal : \(customGoal)")
                        }
                    }
                }
               
                
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel",role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save",role: .confirm) {
                        let frequency:Habit.Frequency
                        switch selectionFrequency {
                        case .daily:
                            frequency = .daily(goalsPerday: dailyGoal)
                        case .weekly:
                            frequency = .weekly(goalsPerWeek: weeklyGoal)
                            
                        case .custom:
                            frequency = .custom(days: Array(selectedDays), goalPerDay: customGoal)
                        }
                        
                        let cleanTiitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        let habit = Habit(title: cleanTiitle, frequency: frequency)
                        onSave(habit)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            })
            .navigationTitle("Add Habit")
        }
    }
    
}
// enum freuency type
enum FrequencyType:String, Identifiable ,CaseIterable{
    
    var id:String  {
        return rawValue
    }
    case daily
    case weekly
    case custom
}


#Preview {
    AddHabitView( onSave:  { habit in
        print("habir is saved")
        
    })
}
