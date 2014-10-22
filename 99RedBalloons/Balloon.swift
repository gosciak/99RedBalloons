//
//  Balloon.swift
//  99RedBalloons
//
//  Created by Doug Gosciak on 2014/10/21.
//  Copyright (c) 2014 Doug Gosciak. All rights reserved.
//

import Foundation
import UIKit

struct Balloon {
    var balloonCount = 0
    var balloonImage = ""
    
    func howManyBallons() {
        println("\(self.balloonCount)")
    }
}
