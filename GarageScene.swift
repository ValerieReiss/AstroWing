//
//  GarageScene.swift
//  StarGlow
//
//  Created by Valerie on 30.03.23.
//

import SpriteKit
import GameplayKit

// geräusch tourne vis
// geräusch click zange


class GarageScene: SKScene {
    
    //private var magicStick : SKEmitterNode?
    
    var scoreCoins: SKLabelNode!
    var playerCoins = 0
    var priceCoins: SKLabelNode!
    var priceZero: SKLabelNode!

    let scoreKey = "scoreKey"
    var playerFusil = 0
    let scoreFusil = "scoreFusil"
    var playerPowerup = Int()
    let scorePowerup = "scorePowerup"
    var playerLaser = 0
    let scoreLaser = "scoreLaser"
    
    let powerup1 = SKSpriteNode(imageNamed: "objectPowerup")
    let powerup2 = SKSpriteNode(imageNamed: "objectPowerup")
    let powerup3 = SKSpriteNode(imageNamed: "objectPowerup")
    let powerup4 = SKSpriteNode(imageNamed: "objectPowerup")
    let powerup5 = SKSpriteNode(imageNamed: "objectPowerup")
    
    var buttonFusilW = SKSpriteNode(imageNamed: "fusil00")
    var buttonFusil = SKSpriteNode(imageNamed: "fusil00")
    var indexW = Int()
    
    let arrayLaser = ["laserBeam1", "laserBeam2", "laserBeam3", "laserBeam4"]
    let arrayFusil = ["fusil00", "fusil00Wblack", "fusil00Wblue", "fusil00Wcyan", "fusil00Wgreen", "fusil00Worange", "fusil00Wpink", "fusil011", "fusil012", "fusil013", "fusil014", "fusil015", "fusil016", "fusil017", "fusil021", "fusil022", "fusil023", "fusil024"]
    
    let player = Player()
    var knochen = SKSpriteNode(imageNamed: "garageKnochen")
    var zange = SKSpriteNode(imageNamed: "garageZange")
    
    var touchLocation = CGPoint()
    
    var labelLaserExplained = SKLabelNode()
    var labelColorExplained = SKLabelNode()
    var labelPowerExplained = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        let userDefaults = UserDefaults.standard
        playerCoins = userDefaults.integer(forKey: scoreKey)
        playerFusil = userDefaults.integer(forKey: scoreFusil)
        playerPowerup = userDefaults.integer(forKey: scorePowerup)
        playerLaser = userDefaults.integer(forKey: scoreLaser)
        
        userDefaults.synchronize()
       
        if let nearEmitter = SKEmitterNode(fileNamed: "Starfield.sks"){
            nearEmitter.position = CGPoint(x: frame.width / 2, y: frame.height * 1.75)
            nearEmitter.zPosition = -4
            nearEmitter.advanceSimulationTime(45)
            addChild(nearEmitter)
        }
        if let farEmitter = SKEmitterNode(fileNamed: "StarfieldFar.sks"){
            farEmitter.position = CGPoint(x: frame.width / 2, y: frame.height * 1.75)
            farEmitter.zPosition = -5
            farEmitter.advanceSimulationTime(180)
            addChild(farEmitter)
        }
        
        let backgroundImage = SKSpriteNode(imageNamed: "bgGarage2")
                //backgroundImage.anchorPoint = CGPointMake(0.5, 0.5)
        backgroundImage.size = CGSize(width: self.frame.width, height: self.frame.height)
        backgroundImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        backgroundImage.zPosition = 0
        addChild(backgroundImage)
        
        let starmap = SKSpriteNode(imageNamed: "discMilkway")
        starmap.size = CGSize(width: 1350, height: 1350)
        starmap.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        starmap.zPosition = -10
        addChild(starmap)
        
        //Texts to Explain Stuff
        
        labelLaserExplained = SKLabelNode(fontNamed: "Chalkduster")
        labelLaserExplained.setScale(2.5)
        labelLaserExplained.zPosition = 5
        labelLaserExplained.text = "Laser"
        labelLaserExplained.position = CGPoint(x: self.frame.minX + 800, y: self.frame.maxY - 150)
        addChild(labelLaserExplained)
        
        labelColorExplained = SKLabelNode(fontNamed: "Chalkduster")
        labelColorExplained.setScale(2.5)
        labelColorExplained.zPosition = 5
        labelColorExplained.text = "Color 100$"
        labelColorExplained.position = CGPoint(x: self.frame.maxX - 400, y: self.frame.maxY - 150)
        addChild(labelColorExplained)
        
        labelPowerExplained = SKLabelNode(fontNamed: "Chalkduster")
        labelPowerExplained.setScale(2.5)
        labelPowerExplained.zPosition = 5
        labelPowerExplained.text = "PowerUp"
        labelPowerExplained.position = CGPoint(x: self.frame.minX + 750, y: self.frame.maxY - 350)
        addChild(labelPowerExplained)
        
        // Change Colors
        let buttonColor = SKShapeNode(rectOf: CGSize(width: 600, height: 150))
        buttonColor.position = CGPoint(x: self.frame.maxX - 400, y: self.frame.maxY - 100)
        buttonColor.strokeColor = .init(white: 1.0, alpha: 0.5)
        buttonColor.fillColor = .init(white: 1.0, alpha: 0.3)
        buttonColor.name = "buttonColor"
        buttonColor.zPosition = 6
        addChild(buttonColor)
        
        let action = SKAction.setTexture(SKTexture(imageNamed: arrayFusil[playerFusil]), resize: true)
        self.player.run(action)
        
        player.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200)
        player.zPosition = 3
        player.name = "player"
        player.texture = SKTexture(imageNamed: arrayFusil[indexW])
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.texture!.size())
        player.physicsBody?.contactTestBitMask = ColliderType.knochen.rawValue | ColliderType.zange.rawValue
        player.physicsBody?.categoryBitMask  = ColliderType.player.rawValue
        player.physicsBody?.collisionBitMask = ColliderType.player.rawValue
        player.setScale(2)
        addChild(player)
        
        indexW = 3 //Int.random(in: 0..<10)
        
        buttonFusil.name = "buttonFusil"
        buttonFusil.position = CGPoint(x: self.frame.maxX - 200, y: self.frame.maxY - 400)
        buttonFusil.zPosition = 2
        addChild(buttonFusil)
        buttonFusil.texture = SKTexture(imageNamed: arrayFusil[indexW])
        buttonFusil.physicsBody = SKPhysicsBody(texture: buttonFusilW.texture!, size: buttonFusilW.texture!.size())
        buttonFusil.physicsBody?.isDynamic = false
        buttonFusil.setScale(1.0)
        
        buttonFusilW.name = "buttonFusilW"
        buttonFusilW.position = CGPoint(x: self.frame.maxX - 600, y: self.frame.maxY - 400)
        buttonFusilW.zPosition = 2
        addChild(buttonFusilW)
        buttonFusilW.texture = SKTexture(imageNamed: arrayFusil[indexW])
        buttonFusilW.physicsBody = SKPhysicsBody(texture: buttonFusilW.texture!, size: buttonFusilW.texture!.size())
        buttonFusilW.physicsBody?.isDynamic = false
        buttonFusilW.setScale(1.0)
        
        /*let bigFusil = SKShapeNode(rectOf: CGSize(width: 600, height: 600))
        bigFusil.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bigFusil.strokeColor = .init(white: 1.0, alpha: 0.0)
        bigFusil.name = "bigFusil"
        bigFusil.zPosition = 1
        addChild(bigFusil)*/
        
        knochen.position = CGPoint(x: self.frame.midX + 600, y: self.frame.minY + 300 )
        knochen.name = "knochen"
        knochen.zPosition = 7
        knochen.texture = SKTexture(imageNamed: "garageKnochen")
        knochen.physicsBody = SKPhysicsBody(texture: knochen.texture!, size: knochen.texture!.size())
        knochen.physicsBody?.isDynamic = false
        knochen.physicsBody?.affectedByGravity = false
        knochen.physicsBody?.allowsRotation = true
        knochen.physicsBody?.angularDamping = 5.0
        knochen.physicsBody?.usesPreciseCollisionDetection = true
        knochen.physicsBody?.contactTestBitMask = ColliderType.player.rawValue | ColliderType.zange.rawValue
        knochen.physicsBody?.categoryBitMask  = ColliderType.knochen.rawValue
        knochen.physicsBody?.collisionBitMask = ColliderType.knochen.rawValue
        knochen.setScale(0.8)
        addChild(knochen)
        
        zange.position = CGPoint(x: self.frame.midX - 600, y: self.frame.minY + 300 )
        zange.name = "zange"
        zange.zPosition = 6
        zange.texture = SKTexture(imageNamed: "garageZange")
        zange.physicsBody = SKPhysicsBody(texture: zange.texture!, size: zange.texture!.size())
        zange.physicsBody?.isDynamic = false
        zange.physicsBody?.affectedByGravity = false
        zange.physicsBody?.allowsRotation = true
        zange.physicsBody?.angularDamping = 5.0
        //zange.physicsBody?.pinned = true
        zange.physicsBody?.usesPreciseCollisionDetection = true
        zange.physicsBody?.contactTestBitMask = ColliderType.player.rawValue | ColliderType.knochen.rawValue
        zange.physicsBody?.categoryBitMask  = ColliderType.zange.rawValue
        zange.physicsBody?.collisionBitMask = ColliderType.zange.rawValue
        zange.setScale(0.7)
        addChild(zange)
        
        let buttonPowerup = SKShapeNode(rectOf: CGSize(width: 830, height: 150), cornerRadius: 10.0)
        buttonPowerup.position = CGPoint(x: self.frame.minX + 1340, y: self.frame.maxY - 300)
        buttonPowerup.strokeColor = .init(white: 1.0, alpha: 1.0)
        buttonPowerup.fillColor = .init(white: 1.0, alpha: 0.3)
        buttonPowerup.name = "buttonPowerup"
        buttonPowerup.zPosition = 2
        addChild(buttonPowerup)
        
        powerup1.setScale(0.6)
        powerup1.zPosition = 3
        powerup1.alpha = 0.5
        powerup1.position = CGPoint(x: self.frame.midX  - 300, y: self.frame.maxY - 300)
        let dicker = SKAction.scale(to: 0.5, duration: 0.6)
        let dunner = SKAction.scale(to: 0.3, duration: 0.6)
        let aufdicken = SKAction.sequence([dicker, dunner])
        powerup1.run(SKAction.repeatForever(aufdicken))
        addChild(powerup1)
        powerup2.setScale(0.4)
        powerup2.zPosition = 3
        powerup2.alpha = 0.5
        powerup2.position = CGPoint(x: self.frame.midX  - 130, y: self.frame.maxY - 300)
        powerup2.run(SKAction.repeatForever(aufdicken))
        addChild(powerup2)
        powerup3.setScale(0.4)
        powerup3.zPosition = 3
        powerup3.alpha = 0.5
        powerup3.position = CGPoint(x: self.frame.midX  + 40, y: self.frame.maxY - 300)
        powerup3.run(SKAction.repeatForever(aufdicken))
        addChild(powerup3)
        powerup4.setScale(0.4)
        powerup4.zPosition = 3
        powerup4.alpha = 0.5
        powerup4.position = CGPoint(x: self.frame.midX  + 210, y: self.frame.maxY - 300)
        powerup4.run(SKAction.repeatForever(aufdicken))
        addChild(powerup4)
        powerup5.setScale(0.4)
        powerup5.zPosition = 3
        powerup5.alpha = 0.5
        powerup5.position = CGPoint(x: self.frame.midX  + 380, y: self.frame.maxY - 300)
        powerup5.run(SKAction.repeatForever(aufdicken))
        addChild(powerup5)
        
        let laserBeam1 = SKSpriteNode(imageNamed: arrayLaser[0])
        laserBeam1.position = CGPoint(x: self.frame.midX  - 300, y: self.frame.maxY - 100)
        laserBeam1.zPosition = 5
        laserBeam1.setScale(2.0)
        addChild(laserBeam1)
        let buttonLaser1 = SKShapeNode(rectOf: CGSize(width: 150, height: 150), cornerRadius: 10.0)
        buttonLaser1.position = CGPoint(x: self.frame.midX - 300, y: self.frame.maxY - 100 )
        buttonLaser1.strokeColor = .init(white: 1.0, alpha: 1.0)
        buttonLaser1.fillColor = .init(white: 1.0, alpha: 0.3)
        buttonLaser1.name = "buttonLaser1"
        buttonLaser1.zPosition = 6
        addChild(buttonLaser1)
        
        let laserBeam2 = SKSpriteNode(imageNamed: arrayLaser[1])
        laserBeam2.position = CGPoint(x: self.frame.midX  - 130, y: self.frame.maxY - 100)
        laserBeam2.zPosition = 5
        laserBeam2.setScale(2.0)
        addChild(laserBeam2)
        let buttonLaser2 = SKShapeNode(rectOf: CGSize(width: 150, height: 150), cornerRadius: 10.0)
        buttonLaser2.position = CGPoint(x: self.frame.midX  - 130, y: self.frame.maxY - 100)
        buttonLaser2.strokeColor = .init(white: 1.0, alpha: 1.0)
        buttonLaser2.fillColor = .init(white: 1.0, alpha: 0.3)
        buttonLaser2.name = "buttonLaser2"
        buttonLaser2.zPosition = 6
        addChild(buttonLaser2)
        
        let laserBeam3 = SKSpriteNode(imageNamed: arrayLaser[2])
        laserBeam3.zPosition = 5
        laserBeam3.position = CGPoint(x: self.frame.midX  + 40, y: self.frame.maxY - 100)
        laserBeam3.setScale(2.0)
        addChild(laserBeam3)
        let buttonLaser3 = SKShapeNode(rectOf: CGSize(width: 150, height: 150), cornerRadius: 10.0)
        buttonLaser3.position = CGPoint(x: self.frame.midX  + 40, y: self.frame.maxY - 100)
        buttonLaser3.strokeColor = .init(white: 1.0, alpha: 1.0)
        buttonLaser3.fillColor = .init(white: 1.0, alpha: 0.3)
        buttonLaser3.name = "buttonLaser3"
        buttonLaser3.zPosition = 6
        addChild(buttonLaser3)
        
        let laserBeam4 = SKSpriteNode(imageNamed: arrayLaser[3])
        laserBeam4.zPosition = 5
        laserBeam4.position =  CGPoint(x: self.frame.midX  + 210, y: self.frame.maxY - 100)
        laserBeam4.setScale(2.0)
        addChild(laserBeam4)
        let buttonLaser4 = SKShapeNode(rectOf: CGSize(width: 150, height: 150), cornerRadius: 10.0)
        buttonLaser4.position = CGPoint(x: self.frame.midX  + 210, y: self.frame.maxY - 100)
        buttonLaser4.strokeColor = .init(white: 1.0, alpha: 1.0)
        buttonLaser4.fillColor = .init(white: 1.0, alpha: 0.3)
        buttonLaser4.name = "buttonLaser4"
        buttonLaser4.zPosition = 6
        addChild(buttonLaser4)
        
        let laserBeam5 = SKSpriteNode(imageNamed: arrayLaser[3])
        laserBeam5.zPosition = 5
        laserBeam5.position =  CGPoint(x: self.frame.midX  + 380, y: self.frame.maxY - 100)
        laserBeam5.setScale(2.0)
        addChild(laserBeam5)
        let buttonLaser5 = SKShapeNode(rectOf: CGSize(width: 150, height: 150), cornerRadius: 10.0)
        buttonLaser5.position = CGPoint(x: self.frame.midX  + 380, y: self.frame.maxY - 100)
        buttonLaser5.strokeColor = .init(white: 1.0, alpha: 1.0)
        buttonLaser5.fillColor = .init(white: 1.0, alpha: 0.3)
        buttonLaser5.name = "buttonLaser4"
        buttonLaser5.zPosition = 6
        addChild(buttonLaser5)
        
        let menu = SKSpriteNode(imageNamed: "buttonLittle.jpg")
        menu.name = "Menu"
        menu.zPosition = 5
        menu.position = CGPoint(x: self.frame.minX + 200, y: self.frame.midY-500)
        menu.setScale(0.35)
        self.addChild(menu)
        
//navibar:
        let coins = SKSpriteNode(imageNamed: "objectCoin.jpg")
        coins.name = "play"
        coins.position = CGPoint(x: self.frame.minX + 200, y: self.frame.maxY - 100)
        coins.setScale(0.5)
        coins.zPosition = 5
        addChild(coins)
        
        scoreCoins = SKLabelNode(fontNamed: "Chalkduster")
        scoreCoins.setScale(2.5)
        scoreCoins.zPosition = 5
        scoreCoins.text = "\(playerCoins)"
        scoreCoins.position = CGPoint(x: self.frame.minX + 400, y: self.frame.maxY - 150)
        addChild(scoreCoins)
        
        priceCoins = SKLabelNode(fontNamed: "Chalkduster")
        priceCoins.setScale(2.5)
        priceCoins.zPosition = 5
        priceCoins.text = "- \(20)"
        priceCoins.alpha = 0.0
        priceCoins.position = CGPoint(x: self.frame.minX+650, y: self.frame.maxY - 150)
        addChild(priceCoins)
        
        priceZero = SKLabelNode(fontNamed: "Chalkduster")
        priceZero.setScale(2.5)
        priceZero.zPosition = 2
        priceZero.text = "? $$$ ?"
        priceZero.alpha = 0.0
        priceZero.position = CGPoint(x: self.frame.minX+650, y: self.frame.maxY - 150)
        addChild(priceZero)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            guard var touch = touches.first else {return}
            touch = (touches.first as UITouch?)!
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if node.name == "button" {
                self.view?.presentScene(DrawScene(size: self.size),
                                        transition: .crossFade(withDuration: 2))
                run("sound-button")
            }
            if node.name == "Menu" {
                self.view?.presentScene(MenuScene(size: self.size),
                                        transition: .crossFade(withDuration: 4))
                run("sound-button")
            }
            if node.name == "knochen" {
                touchLocation = location
                run("sound-Coin")
                let left = SKAction.rotate(byAngle: +1.552, duration: 0.2)
                let klick1 = SKAction.rotate(byAngle: 0.1, duration:0.1)
                let klick2 = SKAction.rotate(byAngle: -0.1, duration:0.1)
                let right = SKAction.rotate(byAngle: -1.552, duration: 0.2)
                let wobble = SKAction.sequence([left, klick1, klick2, klick1, klick2, klick1, klick2, right])
                knochen.run(SKAction.repeat(wobble, count: 1))
            }
            if node.name == "zange" {
                touchLocation = location
                run("sound-Coin")
                let left = SKAction.rotate(byAngle: -1.552, duration: 0.2)
                let klick1 = SKAction.rotate(byAngle: 0.1, duration:0.1)
                let klick2 = SKAction.rotate(byAngle: -0.1, duration:0.1)
                let right = SKAction.rotate(byAngle: +1.552, duration: 0.2)
                let wobble = SKAction.sequence([left, klick1, klick2, klick1, klick2, klick1, klick2, right])
                zange.run(SKAction.repeat(wobble, count: 1))
            }
            if node.name == "buttonLaser1" {
                if playerCoins <= 9 {
                    let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                    let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                    let seq = SKAction.sequence([fadein, fadeout])
                    priceZero.text = "? 10 ?"
                    priceZero.run(seq)
                    run("sound-bomb")
                    return
                }
                if playerLaser == 0 { return }
                playerLaser = 0
                playerCoins -= 10
                priceCoins.text = "-10"
                run("sound-Coin")
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
            }
            if node.name == "buttonLaser2" {
                if playerCoins <= 49 {
                    let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                    let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                    let seq = SKAction.sequence([fadein, fadeout])
                    priceZero.text = "? 50 ?"
                    priceZero.run(seq)
                    run("sound-bomb")
                    return
                }
                if playerLaser == 1 { return }
                playerLaser = 1
                playerCoins -= 50
                priceCoins.text = "-50"
                run("sound-Coin")
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
            }
            if node.name == "buttonLaser3" {
                if playerCoins <= 199 {
                    let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                    let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                    let seq = SKAction.sequence([fadein, fadeout])
                    priceZero.text = "? 200 ?"
                    priceZero.run(seq)
                    run("sound-bomb")
                    return
                }
                if playerLaser == 2 { return }
                playerLaser = 2
                playerCoins -= 200
                priceCoins.text = "-200"
                run("sound-Coin")
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
            }
            if node.name == "buttonLaser4" {
                if playerCoins <= 399 {
                    let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                    let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                    let seq = SKAction.sequence([fadein, fadeout])
                    priceZero.text = "? 400 ?"
                    priceZero.run(seq)
                    run("sound-bomb")
                    return
                }
                if playerLaser == 3 { return }
                playerLaser = 3
                playerCoins -= 400
                priceCoins.text = "-400"
                run("sound-Coin")
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
                run("sound-button")
            }
            
            //Buy Powerups
            if node.name == "buttonPowerup" {
                if playerPowerup == 5 {
                    // label powerup full
                    return
                }
                if playerCoins <= 19 {
                    let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                    let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                    let seq = SKAction.sequence([fadein, fadeout])
                    priceZero.text = "? 50$ ?"
                    priceZero.run(seq)
                    run("sound-bomb")
                    return
                }
                playerPowerup += 1
                playerCoins -= 50
                run("sound-Coin")
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
                run("sound-button")
            }
            
            if node.name == "buttonFusilW"{
                buttonFusilW.alpha = 1.0
                run("sound-button")
                self.indexW += 1
                if indexW == 17{ indexW = 0 }
                let action = SKAction.setTexture(SKTexture(imageNamed: arrayFusil[indexW]), resize: true)
                self.buttonFusilW.run(action)
                
                buttonFusil.alpha = 0.5
            }
            
            if node.name == "buttonFusil"{
                buttonFusil.alpha = 1.0
                run("sound-button")
                self.indexW += 1
                if indexW == 17{ indexW = 0 }
                let action = SKAction.setTexture(SKTexture(imageNamed: arrayFusil[indexW]), resize: true)
                self.buttonFusil.run(action)
                
                buttonFusilW.alpha = 0.5
            }
            
            if node.name == "buttonColor" {
                if playerCoins <= 19 {
                    let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                    let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                    let seq = SKAction.sequence([fadein, fadeout])
                    priceZero.text = "? 100$ ?"
                    priceZero.run(seq)
                    run("sound-bomb")
                    return
                }
                playerCoins -= 100
                run("sound-Coin")
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
                self.playerFusil = indexW
                let action = SKAction.setTexture(SKTexture(imageNamed: arrayFusil[playerFusil]), resize: true)
                self.player.run(action)
                run("sound-button")
            }
            if node.name == "player" {
                let left = SKAction.rotate(byAngle: 0.349, duration: 0.1)
                let right = SKAction.rotate(byAngle: -0.349, duration: 0.1)
                let wobble = SKAction.sequence([left, right])
                player.run(SKAction.repeat(wobble, count: 1))
                run("sound-bomb")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            
            touchLocation = touch.location(in: self)
            let node = self.atPoint(touchLocation)
            if node.name == "knochen" {
                knochen.position = touchLocation
            }
            if node.name == "zange" {
                zange.position = touchLocation
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
           
       
        if (contactMask == 33) { run("sound-Coin") }  // knochen - player
        else if (contactMask == 96) { run("sound-Coin")} // knochen - zange
        else { print("keine ahnung") }
    }
    
    func run(_ fileName: String){
               run(SKAction.playSoundFileNamed(fileName, waitForCompletion: true))
       }
    
    override func update(_ currentTime: TimeInterval) {
        scoreCoins.text = "\(playerCoins)"
        
        let defaults = UserDefaults.standard
        defaults.set(playerCoins, forKey: scoreKey)
        defaults.set(playerFusil, forKey: scoreFusil)
        defaults.set(playerPowerup, forKey: scorePowerup)
        defaults.set(playerLaser, forKey: scoreLaser)
        
        checkForPowerups()
        powerupMenu()
        player.boundsGarage()
        boundsKnochen()
        boundsZange()
    }
    
    func checkForPowerups() {
        enumerateChildNodes(withName: "powerup") { node, _ in
            let powerup = node as! SKSpriteNode
            if powerup.frame.intersects(self.player.frame) {
                self.playerPowerup += 1
                if self.playerPowerup == 6{
                    self.playerPowerup -= 1 }
                self.run("sound-intro")
                powerup.removeFromParent()
            }
        }
    }
    
    func powerupMenu(){
             if self.playerPowerup == 0 {
                 powerup1.alpha = 0.3
                 powerup2.alpha = 0.3
                 powerup3.alpha = 0.3
                 powerup4.alpha = 0.3
                 powerup5.alpha = 0.3
             } else if playerPowerup == 1{
                 powerup1.alpha = 1.0
                 powerup2.alpha = 0.3
                 powerup3.alpha = 0.3
                 powerup4.alpha = 0.3
                 powerup5.alpha = 0.3
             } else if playerPowerup == 2 {
                 powerup1.alpha = 1.0
                 powerup2.alpha = 1.0
                 powerup3.alpha = 0.3
                 powerup4.alpha = 0.3
                 powerup5.alpha = 0.3
             } else if playerPowerup == 3 {
                 powerup1.alpha = 1.0
                 powerup2.alpha = 1.0
                 powerup3.alpha = 1.0
                 powerup4.alpha = 0.3
                 powerup5.alpha = 0.3
             } else if playerPowerup == 4 {
                 powerup1.alpha = 1.0
                 powerup2.alpha = 1.0
                 powerup3.alpha = 1.0
                 powerup4.alpha = 1.0
                 powerup5.alpha = 0.3
             } else if playerPowerup == 5 {
                 powerup1.alpha = 1.0
                 powerup2.alpha = 1.0
                 powerup3.alpha = 1.0
                 powerup4.alpha = 1.0
                 powerup5.alpha = 1.0
             }
             else {return}
     }
    
    func boundsKnochen(){
        let bottomLeft = CGPoint(x: 1300, y: 200)
        let topRight = CGPoint(x: 2200, y: 700)

        if(knochen.position.x <= bottomLeft.x){
            knochen.position.x = bottomLeft.x
        }
        if(knochen.position.x >= topRight.x){
            knochen.position.x = topRight.x
        }
        if(knochen.position.y <= bottomLeft.y){
            knochen.position.y = bottomLeft.y
        }
        if(knochen.position.y >= topRight.y){
            knochen.position.y = topRight.y
        }
    }
    
    func boundsZange(){
        let bottomLeft = CGPoint(x: 400, y: 200)
        let topRight = CGPoint(x: 1300, y: 700)

        if(zange.position.x <= bottomLeft.x){
            zange.position.x = bottomLeft.x
        }
        if(zange.position.x >= topRight.x){
            zange.position.x = topRight.x
        }
        if(zange.position.y <= bottomLeft.y){
            zange.position.y = bottomLeft.y
        }
        if(zange.position.y >= topRight.y){
            zange.position.y = topRight.y
        }
    }
}
