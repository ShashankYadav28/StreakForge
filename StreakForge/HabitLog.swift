//
//  HabitLog.swift
//  StreakForge
//
//  Created by Shashank Yadav on 03/03/26.
//

import Foundation

struct HabitLog:Identifiable,Codable {
    
    var id  = UUID()
    var habitID:Habit.ID
    var count:Int
    var date:Date
    
}
