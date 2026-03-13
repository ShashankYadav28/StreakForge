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
    @State var showHabitSCreen = false
    
    var body: some View {
        NavigationStack {
            List(habitViewModel.habits) { habit in
                HabitRowView(habitViewModel: habitViewModel, habit: habit)
            
            }
            .navigationTitle("Streak Forge")
            .toolbar(content: {
                ToolbarItem {
                    Button {
                        showHabitSCreen = true
                    }label: {
                        Image(systemName: "plus")
                    }
                }
            })
       }
        .sheet(isPresented: $showHabitSCreen, content: {
            Text("HabitScreen ")
        })
        .onAppear {
            habitViewModel.habits = [
                Habit(title: "Drink Water", frequency: .daily(goalsPerday: 8)),
                 Habit(title: "Workout", frequency: .custom(days: [.monday,.wednesday,.friday], goalPerDay: 1)),
                 Habit(title: "ReadBooK", frequency: .weekly(goalsPerWeek: 9))
            ]
        }
        
    }
}
#Preview {
    HabitListView()
}
