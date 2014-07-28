//
//  TitleScene.swift
//  Space Cat
//
//  Created by László Györi on 03/07/14.
//  Copyright (c) 2014 László Györi. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class TitleScene: SKScene {
    
    var pressStartSFX : SKAction?
    var backgroundMusic : AVAudioPlayer?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let background = SKSpriteNode(imageNamed: "splash_1")
        
        background.size = self.size
        background.zPosition = 0
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        self.addChild(background)
        
        self.pressStartSFX = SKAction.playSoundFileNamed("PressStart.caf", waitForCompletion: false)
        
        let url = NSBundle.mainBundle().URLForResource("StartScreen", withExtension: "mp3")
        
        self.backgroundMusic = AVAudioPlayer(contentsOfURL: url, error: nil)
        self.backgroundMusic!.numberOfLoops = -1
        self.backgroundMusic!.prepareToPlay()
        
        self.backgroundMusic!.play()
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        if let scene = GamePlayScene.unarchiveFromFile("GamePlayScene") as? GamePlayScene
        {
            runAction(self.pressStartSFX)
            self.backgroundMusic?.stop()
            
            let skView = self.view as SKView
            let transition = SKTransition.fadeWithDuration(1)
            skView.presentScene(scene, transition:transition)

        }
    }
}
