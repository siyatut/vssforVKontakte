//
//  People.swift
//  vssforVKontakte
//
//  Created by Anastasia Tyutinova on 26/3/2567 BE.
//

import UIKit

struct People {
    
    var id = 0
    private var isInfected = false
    
    init(id: Int = 0, isInfected: Bool = false) {
        self.id = id
        self.isInfected = isInfected
    }
    
    mutating func tryInfect() -> Bool {
        if !isInfected {
            isInfected = true
            return true
        } else {
            return false
        }
    }
    
    func checkInfection() -> Bool {
        return isInfected
    }
}
