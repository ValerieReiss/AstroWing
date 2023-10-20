//
//  DiscScene.swift
//  StarGlow
//
//  Created by Valerie on 31.03.23.
//

import SpriteKit
import GameplayKit

class DiscScene: SKScene {
    var player = SKSpriteNode(imageNamed: "discOldSignsNeon")
    
    private var magicStick : SKEmitterNode?
    
    var touchLocation = CGPoint()
    var startTouch = CGPoint()
    var endTouch = CGPoint()

    var startingAngle:CGFloat?
    var startingTime:TimeInterval?
    
    override func didMove(to view: SKView) {
        
        self.magicStick = SKEmitterNode(fileNamed: "MyParticle.sks")
        if let magicStick = self.magicStick {
            magicStick.particleTexture = SKTexture(imageNamed: "magicstick.png")
            magicStick.particleZPosition = 10
            magicStick.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
        }
        
        let backgroundImage = SKSpriteNode(imageNamed: "BgMenu")
        backgroundImage.anchorPoint = CGPointMake(0.5, 0.5)
        backgroundImage.size = CGSize(width: self.frame.width, height: self.frame.height + 500)
        backgroundImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 200)
        backgroundImage.zPosition = 2
        backgroundImage.isUserInteractionEnabled = false
        addChild(backgroundImage)
        
        let menu = SKSpriteNode(imageNamed: "buttonLittle.jpg")
        menu.name = "Menu"
        menu.zPosition = 5
        menu.position = CGPoint(x: self.frame.midX-700, y: self.frame.midY-450)
        menu.setScale(0.4)
        self.addChild(menu)

        spawnPlayer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
                    startTouch = touch.location(in:self)
                }
            guard var touch = touches.first else {return}
            touch = (touches.first as UITouch?)!
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if node.name == "player" {
                let dx = location.x - node.position.x
                let dy = location.y - node.position.y
                // Store angle and current time
                startingAngle = atan2(dy, dx)
                startingTime = touch.timestamp
                node.physicsBody?.angularVelocity = 0
            }
            
            if node.name == "Menu" {
                self.view?.presentScene(MenuScene(size: self.size),
                                        transition: .crossFade(withDuration: 2))
                run("sound-button")
            }
            if let n = self.magicStick?.copy() as! SKEmitterNode? {
                n.position = location
                self.addChild(n)
            }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
                    endTouch = touch.location(in:self)
                }
            guard var touch = touches.first else {return}
            touch = (touches.first as UITouch?)!
            let location = touch.location(in:self)
            if let n = self.magicStick?.copy() as! SKEmitterNode? {
                n.position = location
                self.addChild(n)
            }
            let node = atPoint(location)
            if node.name == "player" {
                let dx = location.x - node.position.x
                let dy = location.y - node.position.y
                
                let angle = atan2(dy, dx)
                // Calculate angular velocity; handle wrap at pi/-pi
                var deltaAngle = angle - startingAngle!
                if abs(deltaAngle) > CGFloat.pi {
                    if (deltaAngle > 0) {
                        deltaAngle = deltaAngle - CGFloat.pi * 2
                    }
                    else {
                        deltaAngle = deltaAngle + CGFloat.pi * 2
                    }
                }
                let dt = CGFloat(touch.timestamp - startingTime!)
                let velocity = deltaAngle / dt
                
                node.physicsBody?.angularVelocity = velocity
                
                startingAngle = angle
                startingTime = touch.timestamp
            }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
               for touch in touches {
                   endTouch = touch.location(in: self)
               }
           }
 
    override func update(_ currentTime: TimeInterval) {
    }
    
    func spawnPlayer(){
        
        player.zPosition = 3
        player.size = CGSize(width: 2300, height: 2300)
        player.name = "player"
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 16)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
           // Change this property as needed (increase it to slow faster)
        player.physicsBody!.angularDamping = 4
        player.physicsBody?.pinned = true
        player.position = CGPointMake(self.frame.midX, self.frame.midY+700)
        self.addChild(player)
    }
    
    func run(_ fileName: String){
               run(SKAction.playSoundFileNamed(fileName, waitForCompletion: true))
           
       }
}
