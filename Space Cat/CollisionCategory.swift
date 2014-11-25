//
//  CollisionCategory.swift
//  Space Cat
//
//  Created by László Györi on 25/07/14.
//  Copyright (c) 2014 László Györi. All rights reserved.
//

import UIKit

//via http://natecook.com/blog/2014/07/swift-options-bitmask_generator/

/*struct CollisionCategory : RawOptionSetType {
    var value: UInt32 = 0
    init(_ value: UInt32) { self.value = value }
    func toRaw() -> UInt32 { return self.value }
    func getLogicValue() -> Bool { return self.value != 0 }
    static func fromRaw(raw: UInt32) -> CollisionCategory? { return self(raw) }
    static func fromMask(raw: UInt32) -> CollisionCategory { return self(raw) }
    static func convertFromNilLiteral() -> CollisionCategory { return self(0) }
    
    static var CollisionCategoryEnemy: CollisionCategory { return CollisionCategory(1 << 0) }
    static var CollisionCategoryProjectile: CollisionCategory { return CollisionCategory(1 << 1) }
    static var CollisionCategoryDebris: CollisionCategory { return CollisionCategory(1 << 2) }
    static var CollisionCategoryGround: CollisionCategory { return CollisionCategory(1 << 3) }
}
func == (lhs: CollisionCategory, rhs: CollisionCategory) -> Bool { return lhs.value == rhs.value }*/


enum CollisionCategory : UInt32 {
    case CollisionCategoryEnemy = 1,
    CollisionCategoryProjectile = 2,
    CollisionCategoryDebris = 4,
    CollisionCategoryGround = 8
}