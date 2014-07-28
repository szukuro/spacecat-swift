//
//  Util.swift
//  Space Cat
//
//  Created by László Györi on 25/07/14.
//  Copyright (c) 2014 László Györi. All rights reserved.
//

import UIKit

let ProjectileSpeed : Int = 400
let SpaceDogMinSpeed : Int = -100
let SpaceDogMaxSpeed : Int = -50
let MaxLives : Int = 4
let PointsPerHit : Int = 100

// See CollisionCategory.swift for NS_OPTIONS

class Util {
    
    class func random(min: Int, max: Int) -> Int {
        let range : UInt32 = UInt32(max-min)
        let rand : Int = Int(arc4random_uniform(range)) + min
        
        return rand
    }
   
}
