//
//  MachineNode.swift
//  Space Cat
//
//  Created by László Györi on 04/07/14.
//  Copyright (c) 2014 László Györi. All rights reserved.
//

import UIKit
import SpriteKit

class MachineNode: SKSpriteNode {

    convenience init(imageName:NSString) {
        let texture = SKTexture(imageNamed: imageName)
        let color = UIColor.clearColor()
        self.init(texture:texture, color:color, size:texture.size())
    }

    class func machineAtPosition(position:CGPoint) -> MachineNode {
        let machine = MachineNode(imageName:"machine_1")
        machine.position = position
        machine.name = "Machine"
        machine.anchorPoint = CGPointMake(0.5,0)
        machine.zPosition = 8
        
        let texture1 = SKTexture(imageNamed:"machine_1")
        let texture2 = SKTexture(imageNamed:"machine_2")

        let textures : Array<SKTexture> = [ texture1, texture2 ]
        
        let machineAnimation = SKAction.animateWithTextures(textures, timePerFrame:0.1)
        
        let machineRepeat = SKAction.repeatActionForever(machineAnimation)
        
        machine.runAction(machineRepeat)
        
        return machine
    }
}
