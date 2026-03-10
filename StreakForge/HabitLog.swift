//
//  HabitLog.swift
//  StreakForge
//
//  Created by Shashank Yadav on 03/03/26.
//

import Foundation

struct HabitLog:Identifiable {
    
    var id  = UUID()
    var habitID:Habit.ID
    var count:Int
    var date:Date
    
}
