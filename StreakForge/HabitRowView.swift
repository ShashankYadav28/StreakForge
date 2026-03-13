//
//  HabitRowView.swift
//  StreakForge
//
//  Created by Shashank Yadav on 11/03/26.
//

import SwiftUI

struct HabitRowView: View {
    @ObservedObject var habitViewModel:HabitViewModel
    let habit:Habit
    var body: some View {
        HStack {
            VStack(alignment: .leading,spacing: 6){
                Text(habit.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                ProgressView(value: habitViewModel.progressCompletion(habitID: habit.id))
                    .tint(.blue)
                    .scaleEffect(x:1,y:4,anchor:.center)
                    .id(habitViewModel.progressCompletion(habitID: habit.id))
                Text("\(habitViewModel.todaysCompletion(habitID: habit.id))/\(habitViewModel.goal(habit: habit))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("\(habitViewModel.streakCompletion(habitID: habit.id)) days streak ")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.orange)
                
                
            }
            Spacer()
            Button {
                habitViewModel.logCompletion(habitID: habit.id)
                
                
            }
            label: {
                Image(systemName: habitViewModel.iscompletedToday(habitID: habit.id) ? "checkmark.circle.fill":"checkmark.circle")
                    .font(.title3)
                    .foregroundStyle(habitViewModel.iscompletedToday(
                        habitID: habit.id ) ? .green : .blue
                    )
            }
            .disabled(habitViewModel.iscompletedToday(habitID: habit.id))
            
        }
        .padding(.vertical,16)
    }
        
    
}

#Preview {
    HabitRowView(habitViewModel: HabitViewModel(), habit: .init(title: "Drink Water", frequency: .daily(goalsPerday: 8)))
}
