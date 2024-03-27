//
//  SimulationParameters.swift
//  vssforVKontakte
//
//  Created by Anastasia Tyutinova on 26/3/2567 BE.
//

import UIKit

struct SimulationParameters {
    
    var groupSize = 0
    var infectionFactor = 0
    var t = 1
    var tInterval: TimeInterval {
        get {
            return TimeInterval(t)
        }
    }
    
    init(groupSize: Int = 0, infectionFactor: Int = 0, t: Int = 1) {
        
        self.groupSize = groupSize
        self.infectionFactor = infectionFactor
        self.t = t
    }
}
