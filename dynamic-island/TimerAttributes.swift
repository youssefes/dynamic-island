//
//  TimerAttributes.swift
//  dynamic-island
//
//  Created by madar on 08/10/2024.
//

import Foundation
import ActivityKit

struct TimerAttributes: ActivityAttributes {
    var name: String
    
    public typealias TimeTrackingStatus = ContentState
    public struct ContentState: Codable, Hashable {
        var duration: String
        var progress: Double
    }
    
}
