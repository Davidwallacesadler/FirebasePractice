//
//  Workout.swift
//  FirebasePractice
//
//  Created by David Sadler on 5/4/21.
//

import Foundation

public struct Workout: Codable {
    
    let weekDay: String
    
    enum CodingKeys: String, CodingKey {
        case weekDay
    }
}
