//
//  Habit.swift
//  StreakForge
//
//  Created by Shashank Yadav on 03/03/26.
//

import Foundation

struct Habit:Identifiable,Codable{
    var id  = UUID()
    var title:String
    var frequency:Frequency
    var createdDate:Date = Date()
    
    enum Frequency:Codable,Equatable {
        case daily(goalsPerday:Int)
        case weekly(goalsPerWeek:Int)
        case custom(days:[Weekday],goalPerDay:Int)
    }
    
    enum Weekday:String,Identifiable,CaseIterable,Codable {
        
        var id:String {
            return rawValue
        }
    
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
        
    }
}

