//
//  GegnerWeapon.swift
//  AstroKid
//
//  Created by Valerie on 24.04.23.
//

import Foundation
import SpriteKit
import simd

//["object10W", "object10X"]

class GegnerWeapon: SKSpriteNode{
    let arrayGegnerWeapon = ["object10W", "scorpio", "object12X", "capricorn1", "aquarius2", "pisces", "aries1", "taurus", "gemini2", "cancer2", "lion1", "objectCoinGreen"]
    var type: Int
    
    init(type: Int){
        self.type = type
        let texture = SKTexture(imageNamed: arrayGegnerWeapon[type])
        super.init(texture: texture, color: .white, size: texture.size())
        self.name = "gegnerweapon"
        self.zPosition = 2
        
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.contactTestBitMask = ColliderType.player.rawValue | ColliderType.laserBeam.rawValue
        self.physicsBody?.categoryBitMask  = ColliderType.gegnerWeapon.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.gegnerWeapon.rawValue
        //self.setScale(1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("rien compris")
    }
    
    func wobble(){
        let left = SKAction.rotate(byAngle: 0.4, duration: 0.5)
        let right = SKAction.rotate(byAngle: -0.4, duration: 0.5)
        let wobble = SKAction.sequence([left, right])
        run(SKAction.repeatForever(wobble))
    }
    
    func wobbleSanft(){
        let left = SKAction.rotate(byAngle: 0.1, duration: 0.5)
        let right = SKAction.rotate(byAngle: -0.1, duration: 0.5)
        let wobbleSanft = SKAction.sequence([left, right])
        run(SKAction.repeatForever(wobbleSanft))
    }
    
    func step(){
        let left = SKAction.rotate(byAngle: 0.3, duration: 0.1)
        let right = SKAction.rotate(byAngle: -0.3, duration: 0.3)
        let step = SKAction.sequence([left, right])
        run(SKAction.repeatForever(step))
    }
    
    func rotateFull(){
        let turn = SKAction.rotate(byAngle: 3.14*2, duration: 1.5)
        run(SKAction.repeatForever(turn))
    }
    
    func randomCoin(){
        let destination = CGPoint(x: Int.random(in: 300 ..< 2300), y: -100)
        let coinMove = SKAction.move(to: destination, duration: 8)
        let coinRemove = SKAction.removeFromParent()
        let animation = SKAction.sequence([coinMove, coinRemove])
        run(animation)
    }
    
    func hideLeft(){
        let xPosition = Int.random(in: 1000 ..< 1600)
        let destination = CGPoint(x: xPosition, y: -200)
        let move = SKAction.move(to: destination, duration: 8)
        let remove = SKAction.removeFromParent()
        let animation = SKAction.sequence([move, remove])
        run(animation)
    }
    
    func pfeile(){
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: Int.random(in: -600 ..< 0), y: -1000))
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 400)
        let sequence = SKAction.sequence([movement, .removeFromParent()])
        run(sequence)
    }
    
    
    
}
