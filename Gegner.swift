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
    let arrayGegner = ["libra", "scorpio", "sagittarius", "capricorn1", "aquarius1", "pisces", "aries1", "taurus", "gemini1", "cancer1", "lion1", "virgo"]
    var type: Int
    
    init(type: Int){
        self.type = type
        let texture = SKTexture(imageNamed: arrayGegner[type])
        
        super.init(texture: texture, color: .white, size: texture.size())
        
        self.name = "gegner"
        self.zPosition = 2
       
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.allowsRotation = false
        
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
    func wobblefast(){
        let left = SKAction.rotate(byAngle: 0.4, duration: 0.2)
        let right = SKAction.rotate(byAngle: -0.4, duration: 0.2)
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
    
    func sagittarius(){
        let fromright = SKAction.moveTo(x: CGFloat.random(in: 1000..<1200), duration: 3.0)
        fromright.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let turnface = SKAction.scaleX(to: -1, duration: 0.4)
        let turnback = SKAction.scaleX(to: 1, duration: 0.4)
        let back = SKAction.moveTo(x: CGFloat.random(in: 2300 ..< 2400), duration: 3.0)
        back.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let sequence = SKAction.sequence([fromright, turnface, back, turnback])
        run(SKAction.repeatForever(sequence))
    }
    
    func capricorn(){
        let fromleft = SKAction.move(to: CGPoint (x: 2000, y: 1200), duration: 2.0)
        let fromright = SKAction.move(to: CGPoint(x: 500, y: 900), duration: 2.0)
        let turnface = SKAction.scaleX(to: -1, duration: 0.2)
        let turnback = SKAction.scaleX(to: 1, duration: 0.2)
        let nochmalleft = SKAction.move(to: CGPoint(x: 1800,y: 800), duration: 2.0)
        let nochmalright = SKAction.move(to: CGPoint(x: 500, y: 700), duration: 2.0)
        let weggehenlinks = SKAction.move(to: CGPoint(x: 0, y: 600), duration: 2.0)
        let weggehenhoch = SKAction.move(to: CGPoint(x: 0, y: 1200), duration: 2.0)
        let sequence = SKAction.sequence([turnface, fromleft, turnback, fromright, turnface, nochmalleft, turnback, nochmalright,
                                        weggehenlinks, weggehenhoch ])
        run(SKAction.repeatForever(sequence))
    }
    
    func aquarius(){
        let left = SKAction.rotate(byAngle: 0.2, duration: 0.6)
        let right = SKAction.rotate(byAngle: -0.2, duration: 0.6)
        let wobble = SKAction.sequence([left, right])
        let actionwobble = SKAction.repeatForever(wobble)
        run(actionwobble)
        
        let gegner1 = SKTexture(imageNamed: "aquarius1")
        let gegner2 = SKTexture(imageNamed: "aquarius2")
        let gegner3 = SKTexture(imageNamed: "aquarius3")
        
        let setgegner1 = SKAction.setTexture(gegner1)
        
        let setgegner2 = SKAction.animate(with: [gegner2, gegner3], timePerFrame: 0.1)
        let setgegner2anim = SKAction.repeat(setgegner2, count: 20)
        
        let mitte = SKAction.move(to: CGPoint(x: 1200, y: 1000), duration: 3.0)
        mitte.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        
        let wait = SKAction.wait(forDuration: 2.0)
        let wait1 = SKAction.wait(forDuration: 1.0)
        
        let back = SKAction.moveTo(x: 0, duration: 2.0)
        back.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        
        let sequence = SKAction.sequence([mitte, setgegner2anim, wait, setgegner1, back, wait1])
        run(SKAction.repeatForever(sequence))
    }
    
    func pisces(){
        
        let a = SKAction.move(to: CGPoint(x: 700, y: 1100), duration: 1.5)
        let b = SKAction.move(to: CGPoint(x: 1200, y: 1200), duration: 1.0)
        let c = SKAction.move(to: CGPoint(x: 1700, y: 1100), duration: 1.5)
        let d = SKAction.move(to: CGPoint(x: 1700, y: 700), duration: 1.0)
        let e = SKAction.move(to: CGPoint(x: 1200, y: 600), duration: 1.0)
        let f = SKAction.move(to: CGPoint(x: 700, y: 700), duration: 1.0)
        
        let sequence = SKAction.sequence([a, b, c, d, e, f])
        run(SKAction.repeatForever(sequence))
        
      
        /*
        let rect = CGRect(x: 0, y: 0, width: 300, height: 300)//(x: 1000, y: 400, width: 0, height: 0)
        
        let movein = SKAction.move(to: CGPoint(x: 1300, y: 900), duration: 2.0)
        let moveout = SKAction.move(to: CGPoint(x: 1300, y: 1100), duration: 2.0)
        
        let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: 50)
        let path = UIBezierPath(ovalIn: rect)
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 0.2)
       
        let sequence = SKAction.sequence([movein, movement, moveout])
        run(SKAction.repeatForever(sequence))
        */
    }
    
    func gemini() {
        let links = SKAction.move(to: CGPoint(x: 500, y: CGFloat.random(in: 900 ..< 1100)), duration: 1.0)
        links.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let down = SKAction.move(to: CGPoint(x: 900, y: CGFloat.random(in: 700 ..< 800)), duration: 1.0)
        down.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let hoch = SKAction.move(to: CGPoint(x: 1400, y: CGFloat.random(in: 900 ..< 1200)), duration: 1.0)
        hoch.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let rechts = SKAction.move(to: CGPoint(x: 1700, y: CGFloat.random(in: 650 ..< 750)), duration: 1.0)
        rechts.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let up = SKAction.move(to: CGPoint(x: 2000, y: CGFloat.random(in: 1000 ..< 1200)), duration: 1.0)
        up.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        
        let sequence = SKAction.sequence([links, down, hoch, rechts, up, rechts, hoch, down ])
        run(SKAction.repeatForever(sequence))
    }
    
    func moveUp() {
        let movement = SKAction.moveTo(y: 1300, duration: 6.0)
        let movement2 = SKAction.moveTo(y: -1300, duration: 6.0)
        let changeposition = SKAction.moveTo(x: CGFloat.random(in: 500..<2400), duration: 3.0)
        let sequence = SKAction.sequence([movement, movement2, changeposition])
        run(SKAction.repeatForever(sequence))
    }
    
    func taurus() {
        let down = SKAction.moveTo(y: 0, duration: 7.85)
        let hideleft = SKAction.moveTo(x: 0, duration: 0.05)
        let hideup = SKAction.moveTo(y: 1400, duration: 0.05)
        let changeposition = SKAction.moveTo(x: 1000, duration: 0.05)
        let sequence = SKAction.sequence([down, hideleft, hideup, changeposition])
        run(SKAction.repeatForever(sequence))
    }
    
    func cancer() {
        let down = SKAction.moveTo(y: 700, duration: 3.0)
        down.timingFunction = {time in return simd_smoothstep(0, 1, time) }
        let back2 = SKAction.moveTo(y: 1500, duration: 3.0)
        let changeposition = SKAction.moveTo(x: CGFloat.random(in: 800..<2100), duration: 5.0)
        let changeposition1 = SKAction.moveTo(x: CGFloat.random(in: 800..<2100), duration: 5.0)
        let changeposition2 = SKAction.moveTo(x: CGFloat.random(in: 800..<2100), duration: 5.0)
        let sequence = SKAction.sequence([down, back2, changeposition, down, back2, changeposition1, down, back2, changeposition2])
        run(SKAction.repeatForever(sequence))
    }
    
    func hide(){
        let hide = SKAction.moveTo(y: 1500, duration: 2.0)
        run(SKAction.repeatForever(hide))
    }
}
