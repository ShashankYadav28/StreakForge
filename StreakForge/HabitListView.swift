//
//  HabitListView.swift
//  StreakForge
//
//  Created by Shashank Yadav on 10/03/26.
//

import Foundation
import SwiftUI

struct HabitListView:View {
    
    @StateObject var habitViewModel:HabitViewModel = HabitViewModel()
    @State var showHabitScreen = false
    @State var showDuplicateAlert = false
    
    var body: some View {
        NavigationStack {
            
            if habitViewModel.habits.isEmpty {
                HabitEmptyView()
                    .toolbar(content: {
                        ToolbarItem {
                            Button {
                                showHabitScreen = true
                            }label: {
                                Image(systemName: "plus")
                            }
                        }
                    })
            }
            else {
                List {
                    ForEach(habitViewModel.habits) { habit in
                        HabitRowView(habitViewModel: habitViewModel, habit: habit)
                         
                    }
                    .onDelete { indexSet in
                        let index  = indexSet.first
                        if let index = index {
                            let habit  = habitViewModel.habits[index]
                            habitViewModel.deleteHabit(habitID: habit.id)
                            
                        }
                    }
                    
                }
                .navigationTitle("Streak Forge")
                .toolbar(content: {
                    ToolbarItem {
                        Button {
                            showHabitScreen = true
                        }label: {
                            Image(systemName: "plus")
                        }
                    }
                })
                
                
               
            }
         
            
       }
        .alert("Duplicate Habit", isPresented: $showDuplicateAlert, actions: {
            Button("OK",role: .cancel) {
                
            }
        })
        .sheet(isPresented: $showHabitScreen, content: {
            AddHabitView(onSave: { habit in
                let result = habitViewModel.addHabit(habit: habit)
                if result ==  false {
                    showHabitScreen = false
                    showDuplicateAlert = true
                }
            })
        })
//        .onAppear {
//            habitViewModel.habits = [
//                Habit(title: "Drink Water", frequency: .daily(goalsPerday: 8)),
//                 Habit(title: "Workout", frequency: .custom(days: [.monday,.wednesday,.friday], goalPerDay: 1)),
//                 Habit(title: "ReadBooK", frequency: .weekly(goalsPerWeek: 9))
//            ]
//        }
        
    }
}
#Preview {
    HabitListView()
}
