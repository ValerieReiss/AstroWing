//
//  Gegner.swift
//  AstroKid
//
//  Created by Valerie on 24.04.23.
//

import Foundation
import SpriteKit
import simd

class Gegner: SKSpriteNode{
    let arrayGegner = ["object10", "object11", "object12H", "object1", "object2", "object3", "object4", "object5", "object6", "object7", "object8", "object9"]
    var type: Int
    
    init(type: Int){
        self.type = type
        let texture = SKTexture(imageNamed: arrayGegner[type])
        super.init(texture: texture, color: .white, size: texture.size())
        
        self.name = "gegner"
        self.zPosition = 2
       
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.allowsRotation = false
        self.setScale(0.1)
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.contactTestBitMask = ColliderType.player.rawValue | ColliderType.laserBeam.rawValue
        self.physicsBody?.categoryBitMask  = ColliderType.gegner.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.gegner.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("rien compris")
    }
    
    
    func wobble(){
        let left = SKAction.rotate(byAngle: 0.4, duration: 0.6)
        let right = SKAction.rotate(byAngle: -0.4, duration: 0.6)
        let wobble = SKAction.sequence([left, right])
        run(SKAction.repeatForever(wobble))
    }
    func step(){
        let left = SKAction.rotate(byAngle: 0.3, duration: 0.1)
        let right = SKAction.rotate(byAngle: -0.3, duration: 0.3)
        let step = SKAction.sequence([left, right])
        run(SKAction.repeatForever(step))
    }
    func rotate(){
        let rotate = SKAction.rotate(toAngle: 0.5, duration: 0.2)
        let rotateback = SKAction.rotate(toAngle: -0.5, duration: 0.3)
        let dorotate = SKAction.sequence([rotate, rotateback])
        run(SKAction.repeatForever(dorotate))
    }
    func rotateFull(){
        let turn = SKAction.rotate(byAngle: 3.14*2, duration: 1.5)
        run(SKAction.repeatForever(turn))
    }
    func moveAlong(){
        let hin = SKAction.moveTo(x: CGFloat.random(in: 400 ..< 600), duration: 5.0)
        hin.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        //let spawnWeapon = SKAction.run { self.spawnGegnerWeapon() }
        let her = SKAction.moveTo(x: CGFloat.random(in: 1800 ..< 2000), duration: 5.0)
        her.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        
        let sequence = SKAction.sequence([hin, /*spawnWeapon,*/ her])
        run(SKAction.repeatForever(sequence))
    }
    func moveToPlayer(){
        let hin = SKAction.move(to: CGPoint( x: Int.random(in: 800 ..< 1400),
                    y: Int.random(in: 500 ..< 900)), duration: 4.0)
        hin.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let fight = SKAction.move(to: CGPoint(x: CGFloat.random(in: 400 ..< 800), y: 400), duration: 2.5)
        fight.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let weg = SKAction.move(to: CGPoint( x: Int.random(in: 2000 ..< 2300),
                    y: Int.random(in:1000 ..< 1200)), duration: 3.0)
        weg.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let sequence = SKAction.sequence([hin, weg, fight, weg])
        run(SKAction.repeatForever(sequence))
    }
    func moveToPlayerLeft(){
        let wait = SKAction.wait(forDuration: 3)
        let fight = SKAction.move(to: CGPoint(x: CGFloat.random(in: 1200 ..< 1500), y: 500), duration: 3.0)
        fight.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let weg = SKAction.move(to: CGPoint(x: Int.random(in: 300..<600), y: 1200), duration: 3.0)
        weg.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let sequence = SKAction.sequence([ fight, weg, wait])
        run (SKAction.repeatForever(sequence))
    }
    func moveToPlayerRight() {
        let wait = SKAction.wait(forDuration: 3)
        let fight = SKAction.move(to: CGPoint(x: CGFloat.random(in: 900 ..< 1200), y: 400), duration: 3.0)
        fight.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let weg = SKAction.move(to: CGPoint(x: Int.random(in: 1800..<2000), y: 1300), duration: 3.0)
        weg.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let sequence = SKAction.sequence([fight, weg, wait])
        run (SKAction.repeatForever(sequence))
    }
    func moveToPlayerRighttoLeft() {
        let anfang = SKAction.move(to: CGPoint(x: 2000, y: 1000), duration: 3.0)
        anfang.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let fight = SKAction.move(to: CGPoint(x: CGFloat.random(in: 1100 ..< 1300), y: 400), duration: 2.0)
        fight.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let weg = SKAction.move(to: CGPoint(x: 0, y: 1200), duration: 3.0)
        weg.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let hide1 = SKAction.moveTo(y: 1500, duration: 0.2)
        let hide2 = SKAction.moveTo(x: 2400, duration: 0.2)
        let sequence = SKAction.sequence([anfang, fight, weg, hide1, hide2])
        run (SKAction.repeatForever(sequence))
    }
    func moveHideLeft(){}
    
    func moveHideRight(){
        let fromright = SKAction.moveTo(x: CGFloat.random(in: 1400..<1600), duration: 3.0)
        fromright.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let back = SKAction.moveTo(x: CGFloat.random(in: 2000 ..< 2400), duration: 3.0)
        back.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        //let spawnWeapon = SKAction.run { self.spawnGegnerWeapon() }
        let sequence = SKAction.sequence([fromright, /*spawnWeapon, spawnWeapon,*/ back])
        run(SKAction.repeatForever(sequence))
    }
    func moveDown() {
        let mitte = SKAction.move(to: CGPoint(x: CGFloat.random(in: 1200 ..< 1300), y: 1000), duration: 6.0)
        mitte.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let down = SKAction.moveTo(y: 0, duration: 6.0)
        down.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let back1 = SKAction.moveTo(x: 0, duration: 0.2)
        let back2 = SKAction.moveTo(y: 800, duration: 0.2)
        let sequence = SKAction.sequence([mitte, down, back1, back2])
        run(SKAction.repeatForever(sequence))
    }
    func dance() {
        let links = SKAction.move(to: CGPoint(x: CGFloat.random(in: 500 ..< 600), y: CGFloat.random(in: 1000 ..< 1100)), duration: 2.0)
        links.timingFunction = {time in return simd_smoothstep(0, 1, time) }
       
        let down = SKAction.move(to: CGPoint(x: CGFloat.random(in: 700 ..< 800), y: CGFloat.random(in: 700 ..< 800)), duration: 2.0)
        down.timingFunction = {time in return simd_smoothstep(0, 1, time) }
       
        let rechts = SKAction.move(to: CGPoint(x: CGFloat.random(in: 1900 ..< 2000), y: CGFloat.random(in: 700 ..< 800)), duration: 2.0)
        rechts.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        
        let up = SKAction.move(to: CGPoint(x: CGFloat.random(in: 1900 ..< 2000), y: CGFloat.random(in: 1000 ..< 1200)), duration: 2.0)
        up.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        
        let sequence = SKAction.sequence([links, down, rechts, up ])
        run(SKAction.repeatForever(sequence))
        
    }
    func moveUp() {
        let movement = SKAction.moveTo(y: 1300, duration: 6.0)
        let movement2 = SKAction.moveTo(y: -1300, duration: 6.0)
        let changeposition = SKAction.moveTo(x: CGFloat.random(in: 500..<2400), duration: 3.0)
        let sequence = SKAction.sequence([movement, movement2, changeposition])
        run(SKAction.repeatForever(sequence))
        
    }
    func moveCancer() {
        let down = SKAction.moveTo(y: 100, duration: 6.0)
        down.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let back2 = SKAction.moveTo(y: 800, duration: 0.2)
        let sequence = SKAction.sequence([down, back2])
        run(SKAction.repeatForever(sequence))
    }
    
    func hide(){
        let hide = SKAction.moveTo(y: 1500, duration: 6.0)
        run(SKAction.repeatForever(hide))
    }
}
