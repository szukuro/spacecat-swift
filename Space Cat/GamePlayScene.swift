//
//  GamePlayScene.swift
//  Space Cat
//
//  Created by László Györi on 03/07/14.
//  Copyright (c) 2014 László Györi. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GamePlayScene: SKScene {
    
    var spaceCat : SpaceCatNode?
    var lastUpdateTimeInterval : NSTimeInterval?
    var timeSinceEnemyAdded : NSTimeInterval = 0
    var totalGameTime : NSTimeInterval = 0
    var minSpeed : Int = SpaceDogMinSpeed
    var addEnemyTimeInterval : NSTimeInterval = 1.5
    
    var damageSFX : SKAction?
    var explodeSFX : SKAction?
    var laserSFX : SKAction?
    var backgroundMusic : AVAudioPlayer?
    var gameOverMusic : AVAudioPlayer?
    
    var gameOver : Bool = false
    var restart : Bool = false
    var gameOverDisplayed : Bool = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.timeSinceEnemyAdded = 0
        
        let background = SKSpriteNode(imageNamed: "background_1")
        
        background.size = self.size
        background.zPosition = -1 //was 0 in video
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        self.addChild(background)
        
        
        let machine = MachineNode.machineAtPosition(CGPointMake(CGRectGetMidX(self.frame), 12))
        self.addChild(machine)
        
        let spaceCat = SpaceCatNode.spaceCatAtPosition(CGPointMake(machine.position.x, machine.position.y - 2))
        self.addChild(spaceCat)
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        self.physicsWorld.contactDelegate = self
        
        let size = CGSizeMake(self.frame.size.width, 22)
        let ground = GroundNode.groundWithSize(size)
        
        self.addChild(ground)
        
        self.setupSounds()
        
        let hud = HudNode.hudAtPosition(CGPointMake(0,self.frame.size.height-20), frame:self.frame)
        self.addChild(hud)
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        if (self.lastUpdateTimeInterval) {
            self.timeSinceEnemyAdded = self.timeSinceEnemyAdded + currentTime - self.lastUpdateTimeInterval!
            self.totalGameTime = self.totalGameTime + currentTime - self.lastUpdateTimeInterval!
        }
        
        if (self.timeSinceEnemyAdded > self.addEnemyTimeInterval && !self.gameOver) {
            self.addSpaceDog()
            self.timeSinceEnemyAdded = 0
        }
        
        self.lastUpdateTimeInterval = currentTime
        
        
        if ( self.totalGameTime > 480) {
            // 480 / 60 = 8 minutes
            self.addEnemyTimeInterval = 0.5
            self.minSpeed = -160
        } else if (self.totalGameTime > 240) {
            // 240 / 60 = 4 minutes
            self.addEnemyTimeInterval = 0.65
            self.minSpeed = -150
        } else if (self.totalGameTime > 120) {
            // 120 / 60 = 2 minutes
            self.addEnemyTimeInterval = 0.75
            self.minSpeed = -125
        } else if (self.totalGameTime > 30) {
            self.addEnemyTimeInterval = 1.0
            self.minSpeed = -100
        }
        
        if (self.gameOver && !self.gameOverDisplayed) {
            self.performGameOver()
        }
    }
    
    func setupSounds() {
        self.damageSFX = SKAction.playSoundFileNamed("Damage.caf", waitForCompletion: false)
        self.explodeSFX = SKAction.playSoundFileNamed("Explode.caf", waitForCompletion: false)
        self.laserSFX = SKAction.playSoundFileNamed("Laser.caf", waitForCompletion: false)
        
        let url = NSBundle.mainBundle().URLForResource("Gameplay", withExtension: "mp3")
        
        self.backgroundMusic = AVAudioPlayer(contentsOfURL: url, error: nil)
        self.backgroundMusic!.numberOfLoops = -1
        self.backgroundMusic!.prepareToPlay()
        
        let gameOverUrl = NSBundle.mainBundle().URLForResource("GameOver", withExtension: "mp3")
        
        self.gameOverMusic = AVAudioPlayer(contentsOfURL: gameOverUrl, error: nil)
        self.gameOverMusic!.numberOfLoops = 1
        self.gameOverMusic!.prepareToPlay()
      
        self.backgroundMusic!.play()
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if (!self.gameOver) {
            for touch: AnyObject in touches {
                let location = touch.locationInNode(self)
            
                self.shootProjectileTowardsPosition(location)
            }
        } else if (self.restart) {
            
            self.removeAllChildren()
            
            let scene = GamePlayScene(size: self.view.bounds.size)
            self.view.presentScene(scene)
        }
    }

    func performGameOver() {
        let gameOverNode = GameOverNode.gameOverAtPosition(CGPointMake(CGRectGetMidX(self.frame),
                                                                   CGRectGetMidY(self.frame)))
        self.addChild(gameOverNode)
        self.restart = true
        self.gameOverDisplayed = true
        
        gameOverNode.performAnimation()
        
        self.backgroundMusic?.stop()
        self.gameOverMusic?.play()
    }

    func shootProjectileTowardsPosition(position:CGPoint) {
        if (!spaceCat) {
            spaceCat = self.childNodeWithName("SpaceCat") as? SpaceCatNode
        }
        
        spaceCat?.performTap()
        
        let machine = self.childNodeWithName("Machine")
        

        let projectile = ProjectileNode.projectileAtPosition(CGPointMake(machine.position.x, machine.position.y + machine.frame.size.height - 15 ))
        
        self.addChild(projectile)
        
        projectile.moveTowardsPosition(position)
        
        self.runAction(self.laserSFX)
    }
    
    
    func addSpaceDog() {
        let randomSpaceDog = Util.random(0, max: 2)
        let spaceDog = SpaceDogNode.spaceDogOfType(SpaceDogType.fromRaw(randomSpaceDog)!)
        let dy = Util.random(self.minSpeed, max: SpaceDogMaxSpeed)
        let dyf = CGFloat(dy)
        
        spaceDog.physicsBody.velocity = CGVectorMake(0, dyf)
        
        let y = self.frame.size.height + spaceDog.size.height
        let x = Util.random(10 + Int(spaceDog.size.width), max: (Int(self.frame.size.width) - 10))
     
        spaceDog.position = CGPointMake(CGFloat(x), y)
        self.addChild(spaceDog)
        
    }
    
    func addPoints(points : NSInteger) {
        let hud = self.childNodeWithName("HUD") as HudNode
        hud.addPoints(points)
    }
    
    func loseLife() {
        let hud = self.childNodeWithName("HUD") as HudNode
        self.gameOver = hud.loseLife()
    }
    
    func createDebrisAtPosition(position:CGPoint) {
        let numberOfPieces = Util.random(5, max: 20)
        
        for var i = 0; i < numberOfPieces; ++i {
            let randomPiece = Util.random(1, max: 4)
            let imageName = "debri_\(randomPiece)"
            
            var debris = SKSpriteNode(imageNamed: imageName)
            debris.position = position
            self.addChild(debris)
            
            debris.physicsBody = SKPhysicsBody(rectangleOfSize: debris.frame.size)

            debris.physicsBody.categoryBitMask = CollisionCategory.CollisionCategoryDebris.value
            debris.physicsBody.contactTestBitMask = 0
            debris.physicsBody.collisionBitMask = CollisionCategory.CollisionCategoryGround.value |
                                                    CollisionCategory.CollisionCategoryDebris.value
            debris.name = "Debris"
        
            let velocityX = Util.random(-150, max: 150)
            let velocityY = Util.random(150, max: 350)
            
            debris.physicsBody.velocity = CGVectorMake(CGFloat(velocityX), CGFloat(velocityY))
            
            debris.runAction(SKAction.waitForDuration(2), completion: { debris.removeFromParent() })
        }
        
        let explosionPath = NSBundle.mainBundle().pathForResource("Explosion", ofType: "sks")
        
        let explosion = NSKeyedUnarchiver.unarchiveObjectWithFile(explosionPath) as SKEmitterNode
        
        explosion.position = position
        self.addChild(explosion)
        explosion.runAction(SKAction.waitForDuration(2), completion: { explosion.removeFromParent() })
    }

}

extension GamePlayScene : SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody : SKPhysicsBody
        var secondBody : SKPhysicsBody
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask == CollisionCategory.CollisionCategoryEnemy.value &&
                secondBody.categoryBitMask == CollisionCategory.CollisionCategoryProjectile.value) {
            if let spaceDog = firstBody.node as? SpaceDogNode {
            
                let projectile = secondBody.node as ProjectileNode
                
                self.addPoints(PointsPerHit)
                
                self.runAction(self.explodeSFX)
            
                spaceDog.removeFromParent()
                projectile.removeFromParent()
            } else {
                //somtimes contact.bodyA is nil for some reason
                //doesn't affect gameplay as long as it's handled
                NSLog("\(contact.bodyA)")
                NSLog("\(firstBody.node)")
                NSLog("\(firstBody.categoryBitMask)")
            }
            
        }
        else if (firstBody.categoryBitMask == CollisionCategory.CollisionCategoryEnemy.value &&
        secondBody.categoryBitMask == CollisionCategory.CollisionCategoryGround.value) {
            self.runAction(self.damageSFX)
            
            let spaceDog = firstBody.node as SpaceDogNode
            spaceDog.removeFromParent()

            self.loseLife()
        }
        
        self.createDebrisAtPosition(contact.contactPoint)
    }

}
