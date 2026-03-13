//
//  AddHabitScreen.swift
//  StreakForge
//
//  Created by Shashank Yadav on 13/03/26.
//

import SwiftUI

struct AddHabitView: View {
    @State var title:String = ""
    @State var selectionFrequency:FrequencyType = .daily
    @State var goal:Int = 1
    @State var selectedDays: Set<Habit.Weekday> = []
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
                        Stepper(value:$goal,in: 1...20) {
                            Text("Daily Goal : \(goal)")
                        }
                        
                    }
                case .weekly:
                    Section("Goal Per Week"){
                        Stepper(value:$goal,in: 1...25) {
                            Text("Weekly Goal : \(goal)")
                        }
                        
                    }
                    
                case .custom:
                    Section("Select days") {
                        ForEach(Habit.Weekday.allCases) { data in
                            
                            
                        }
                    }
                    Section("Goal Per Day"){
                        Stepper(value:$goal,in: 0...20) {
                            Text("Goal : \(goal)")
                        }
                    }
                }
               
                
            }
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
    AddHabitView()
}
