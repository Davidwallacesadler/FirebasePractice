//
//  Workout.swift
//  FirebasePractice
//
//  Created by David Sadler on 5/4/21.
//

import Foundation

public struct WorkoutWeek: Codable {
    
    let startDate: String
    let endDate: String
    let workouts: Array<Workout>
    
    enum CodingKeys: String, CodingKey {
        case startDate
        case endDate
        case workouts
    }
}
