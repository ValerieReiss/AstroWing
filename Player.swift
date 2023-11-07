//
//  Player.swift
//  StarGlow
//
//  Created by Valerie on 31.03.23.
//

import Foundation
import SpriteKit
import simd


struct PhysicsCategory {
    static let player         : UInt32 = 0x1 << 1
    static let laserBeam      : UInt32 = 0x1 << 2
    static let gegner         : UInt32 = 0x1 << 4
    static let weapon1        : UInt32 = 0x1 << 8
    static let weapon2        : UInt32 = 0x1 << 16
    static let knochen        : UInt32 = 0x1 << 32
    static let zange          : UInt32 = 0x1 << 64
    static let weapon3        : UInt32 = 0x1 << 128
}

class Player: SKSpriteNode{
    init(){
    let texture = SKTexture(imageNamed: "fusil00")
    super.init(texture: texture, color: UIColor.clear, size: texture.size())
    self.name = "player"
    self.zPosition = 2
    let body:SKPhysicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0, size: texture.size() )
    self.physicsBody = body
    self.physicsBody?.allowsRotation = false
    
    self.physicsBody?.isDynamic = true
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.contactTestBitMask = ColliderType.gegner.rawValue
    self.physicsBody?.categoryBitMask = ColliderType.player.rawValue
    self.physicsBody?.collisionBitMask = ColliderType.player.rawValue
    //self.physicsBody?.categoryBitMask = PhysicsCategory.player
    self.setScale(0.5)
    
        //self.physicsBody?.contactTestBitMask = CollisionType.gegner.rawValue | CollisionType.gegnerWeapon.rawValue | CollisionType.gegnerWeapon1.rawValue | CollisionType.knochen.rawValue
}

required init?(coder aDecoder: NSCoder) {
    fatalError("LOL NO")
}

func boundsCheckPlayer(){
    let bottomLeft = CGPoint(x: 400, y: 500)
    let topRight = CGPoint(x: 2500, y: 1500)

    if(self.position.x <= bottomLeft.x){
        self.position.x = bottomLeft.x
    }
    if(self.position.x >= topRight.x){
        self.position.x = topRight.x
    }
    if(self.position.y <= bottomLeft.y){
        self.position.y = bottomLeft.y
    }
    if(self.position.y >= topRight.y){
        self.position.y = topRight.y
    }
}

    func boundsGarage(){
        let bottomLeft = CGPoint(x: 550, y: 400)
        let topRight = CGPoint(x: 1800, y: 1200)

        if(self.position.x <= bottomLeft.x){
            self.position.x = bottomLeft.x
        }
        if(self.position.x >= topRight.x){
            self.position.x = topRight.x
        }
        if(self.position.y <= bottomLeft.y){
            self.position.y = bottomLeft.y
        }
        if(self.position.y >= topRight.y){
            self.position.y = topRight.y
        }
    }
    
    
}
