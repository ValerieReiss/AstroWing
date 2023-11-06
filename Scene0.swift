//
//  Scene0.swift
//  StarGlow
//
//  Created by Valerie on 31.03.23.
//

enum CollisionType: UInt32 {
    case player = 1
    case laserBeam = 2
    case gegner = 4
    case gegnerWeapon = 8
    case gegnerWeapon1 = 16
    case knochen = 32
}
enum ColliderType: UInt32 {
    case player = 1
    case laserBeam = 2
    case gegner = 4
    case gegnerWeapon = 8
    case gegnerWeapon1 = 16
    case knochen = 32
    case zange = 64
}

import SpriteKit
import GameplayKit
import simd


class Scene0: SKScene, SKPhysicsContactDelegate {
    let arrayLaser = ["laserBeam1", "laserBeam2", "laserBeam3", "laserBeam4"]
    let arrayFusil = ["fusil00", "fusil00Wblack", "fusil00Wblue", "fusil00Wcyan", "fusil00Wgreen", "fusil00Worange", "fusil00Wpink", "fusil011", "fusil012", "fusil013", "fusil014", "fusil015", "fusil016", "fusil017", "fusil021", "fusil022", "fusil023", "fusil024"]
    let arrayGegner = ["object10", "scorpio", "sagittarius", "capricorn1", "aquarius1", "pisces", "aries1", "taurus", "gemini1", "cancer1", "lion1", "virgo"]
    var indexGegner = 0
    let player = Player()
    let gegner = Gegner(type: 0)
    //let gegnerWeapon = SKSpriteNode()
    let gegnerWeapon = GegnerWeapon(type: 0)
    
    var normalPlayerPositionY = 550.0
    var normalPlayerPositionX = 1300
    var playableRectArea:CGRect = CGRectZero
    
    var lastUpdateTime:TimeInterval = 0
    var dt:TimeInterval = 0
    
    var priceCoins: SKLabelNode!
    var scoreCoins: SKLabelNode!
    
    var labelplayerHearts: SKLabelNode!
    var labelgegnerHearts: SKLabelNode!
    
    var shotweapon = 0
    
    var playerPowerup = 0
    let powerup1 = SKSpriteNode(imageNamed: "objectPowerup")
    let powerup2 = SKSpriteNode(imageNamed: "objectPowerup")
    let powerup3 = SKSpriteNode(imageNamed: "objectPowerup")
    let powerup4 = SKSpriteNode(imageNamed: "objectPowerup")
    let powerup5 = SKSpriteNode(imageNamed: "objectPowerup")
    
    var battery0 = SKSpriteNode(imageNamed: "naviBattery0")
    var battery1 = SKSpriteNode(imageNamed: "naviBattery1")
    var battery2 = SKSpriteNode(imageNamed: "naviBattery2")
    var battery3 = SKSpriteNode(imageNamed: "naviBattery3")
    var battery4 = SKSpriteNode(imageNamed: "naviBattery4")
    var battery5 = SKSpriteNode(imageNamed: "naviBattery5")
    var playerHearts = 2000
    var batteryG0 = SKSpriteNode(imageNamed: "naviBatteryG0")
    var batteryG1 = SKSpriteNode(imageNamed: "naviBatteryG1")
    var batteryG2 = SKSpriteNode(imageNamed: "naviBatteryG2")
    var batteryG3 = SKSpriteNode(imageNamed: "naviBatteryG3")
    var batteryG4 = SKSpriteNode(imageNamed: "naviBatteryG4")
    var batteryG5 = SKSpriteNode(imageNamed: "naviBatteryG5")
    var gegnerHearts = 2000
    
    var zahl = 0
    
    var playerCoins = Int()
    let scoreKey = "scoreKey"
    var playerFusil = Int()
    let scoreFusil = "scoreFusil"
    let scorePowerup = "scorePowerup"
    var playerLaser = Int()
    let scoreLaser = "scoreLaser"
    var laserBeam = SKSpriteNode()
    
    var playerLevel = Int()
    let scoreLevel = "scoreLevel"
    
    private var magicStick : SKEmitterNode?
    
    override func didMove(to view: SKView) {
        let bgGamePlay = SKSpriteNode(imageNamed: "bgGamePlay")
        bgGamePlay.size = CGSize(width: self.frame.width, height: self.frame.height)
        bgGamePlay.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bgGamePlay.zPosition = -10
        bgGamePlay.isUserInteractionEnabled = false
        addChild(bgGamePlay)
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
        let backgroundImage = SKSpriteNode(imageNamed: "BgMenu")
        backgroundImage.anchorPoint = CGPointMake(0.5, 0.5)
        backgroundImage.size = CGSize(width: self.frame.width, height: self.frame.height + 500)
        backgroundImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 200)
        backgroundImage.zPosition = 3
        backgroundImage.isUserInteractionEnabled = false
        addChild(backgroundImage)
        let menu = SKSpriteNode(imageNamed: "buttonLittle.jpg")
        menu.name = "Menu"
        menu.zPosition = 5
        menu.position = CGPoint(x: self.frame.midX-600, y: self.frame.minY + 180)
        menu.setScale(0.3)
        self.addChild(menu)
        
        //navibar:
        let coins = SKSpriteNode(imageNamed: "objectCoin.jpg")
        coins.name = "play"
        coins.position = CGPoint(x: self.frame.minX + 300, y: self.frame.maxY - 200)
        coins.setScale(0.3)
        coins.zPosition = 5
        addChild(coins)
        
        
        labelplayerHearts = SKLabelNode(fontNamed: "Chalkduster")
        labelplayerHearts.setScale(2.0)
        labelplayerHearts.zPosition = 5
        labelplayerHearts.text = "\(playerHearts)"
        labelplayerHearts.position = CGPoint(x: self.frame.minX + 200, y: self.frame.maxY - 100)
        addChild(labelplayerHearts)
        
        labelgegnerHearts = SKLabelNode(fontNamed: "Chalkduster")
        labelgegnerHearts.setScale(2.0)
        labelgegnerHearts.zPosition = 5
        labelgegnerHearts.text = "\(gegnerHearts)"
        labelgegnerHearts.position = CGPoint(x: self.frame.maxX - 200, y: self.frame.maxY - 100)
        addChild(labelgegnerHearts)
        
        scoreCoins = SKLabelNode(fontNamed: "Chalkduster")
        scoreCoins.setScale(2.0)
        scoreCoins.zPosition = 5
        scoreCoins.text = "\(playerCoins)"
        scoreCoins.position = CGPoint(x: self.frame.minX + 500, y: self.frame.maxY - 230)
        addChild(scoreCoins)
        
        priceCoins = SKLabelNode(fontNamed: "Chalkduster")
        priceCoins.setScale(2.0)
        priceCoins.zPosition = 5
        priceCoins.text = ""
        priceCoins.alpha = 0.0
        priceCoins.position = CGPoint(x: self.frame.minX + 700, y: self.frame.maxY - 230)
        addChild(priceCoins)
        
        battery0.position = CGPoint(x: self.frame.midX-850, y: self.frame.midY+550)
        battery0.setScale(0.7)
        battery0.alpha = 0.0
        battery0.zPosition = 5
        addChild(battery0)
        battery1.position = CGPoint(x: self.frame.midX-850, y: self.frame.midY+550)
        battery1.setScale(0.7)
        battery1.alpha = 0.0
        battery1.zPosition = 6
        addChild(battery1)
        battery2.position = CGPoint(x: self.frame.midX-850, y: self.frame.midY+550)
        battery2.setScale(0.7)
        battery2.alpha = 0.0
        battery2.zPosition = 7
        addChild(battery2)
        battery3.position = CGPoint(x: self.frame.midX-850, y: self.frame.midY+550)
        battery3.setScale(0.7)
        battery3.alpha = 0.0
        battery3.zPosition = 8
        addChild(battery3)
        battery4.position = CGPoint(x: self.frame.midX-850, y: self.frame.midY+550)
        battery4.setScale(0.7)
        battery4.alpha = 0.0
        battery4.zPosition = 9
        addChild(battery4)
        battery5.position = CGPoint(x: self.frame.midX-850, y: self.frame.midY+550)
        battery5.setScale(0.7)
        battery5.alpha = 0.0
        battery5.zPosition = 10
        addChild(battery5)
        
        checkHearts()
        
        batteryG0.position = CGPoint(x: self.frame.midX+850, y: self.frame.midY+550)
        batteryG0.setScale(0.7)
        batteryG0.alpha = 0.0
        batteryG0.zPosition = 5
        addChild(batteryG0)
        batteryG1.position = CGPoint(x: self.frame.midX+850, y: self.frame.midY+550)
        batteryG1.setScale(0.7)
        batteryG1.alpha = 0.0
        batteryG1.zPosition = 6
        addChild(batteryG1)
        batteryG2.position = CGPoint(x: self.frame.midX+850, y: self.frame.midY+550)
        batteryG2.setScale(0.7)
        batteryG2.alpha = 0.0
        batteryG2.zPosition = 7
        addChild(batteryG2)
        batteryG3.position = CGPoint(x: self.frame.midX+850, y: self.frame.midY+550)
        batteryG3.setScale(0.7)
        batteryG3.alpha = 0.0
        batteryG3.zPosition = 8
        addChild(batteryG3)
        batteryG4.position = CGPoint(x: self.frame.midX+850, y: self.frame.midY+550)
        batteryG4.setScale(0.7)
        batteryG4.alpha = 0.0
        batteryG4.zPosition = 9
        addChild(batteryG4)
        batteryG5.position = CGPoint(x: self.frame.midX+850, y: self.frame.midY+550)
        batteryG5.setScale(0.7)
        batteryG5.alpha = 0.0
        batteryG5.zPosition = 10
        addChild(batteryG5)
        
        checkGegnerHearts()
        
        //CONTROLSSSS:
        let laser = SKSpriteNode(imageNamed: "controlsLeft")
        laser.name = "controlsLaser"
        laser.position = CGPoint(x: self.frame.midX+700, y: self.frame.midY-450)
        laser.zPosition = 6
        laser.setScale(2.3)
        self.addChild(laser)
        
        let links = SKShapeNode(circleOfRadius: 100)
        links.name = "links"
        links.zPosition = 6
        links.position = CGPoint(x: self.frame.midX-1050, y: self.frame.midY-280)
        links.strokeColor = .init(white: 0.0, alpha: 1.0)
        links.setScale(2)
        self.addChild(links)
        
        let rechts = SKShapeNode(circleOfRadius: 100)
        rechts.name = "rechts"
        rechts.zPosition = 6
        rechts.position = CGPoint(x: self.frame.midX+1050, y: self.frame.midY-280)
        rechts.strokeColor = .init(white: 0.0, alpha: 1.0)
        rechts.setScale(2)
        self.addChild(rechts)
        
        let Powerups = SKShapeNode(rectOf: CGSize(width: 500, height: 200))
        Powerups.position = CGPoint(x: self.frame.midX, y: self.frame.midY-360)
        Powerups.strokeColor = .init(white: 1.0, alpha: 1.0)
        Powerups.name = "Powerups"
        Powerups.zPosition = 6
        addChild(Powerups)
        
        powerup1.setScale(0.3)
        powerup1.zPosition = 2
        powerup1.alpha = 0.3
        powerup1.position = CGPoint(x: self.frame.midX - 180, y: self.frame.midY-350)
        let dicker = SKAction.scale(to: 0.3, duration: 0.6)
        let dunner = SKAction.scale(to: 0.2, duration: 0.6)
        let aufdicken = SKAction.sequence([dicker, dunner])
        powerup1.run(SKAction.repeatForever(aufdicken))
        addChild(powerup1)
        powerup2.setScale(0.3)
        powerup2.zPosition = 2
        powerup2.alpha = 0.3
        powerup2.position = CGPoint(x: self.frame.midX - 90, y: self.frame.midY-350)
        powerup2.run(SKAction.repeatForever(aufdicken))
        addChild(powerup2)
        powerup3.setScale(0.3)
        powerup3.zPosition = 2
        powerup3.alpha = 0.3
        powerup3.position = CGPoint(x: self.frame.midX , y: self.frame.midY-350)
        powerup3.run(SKAction.repeatForever(aufdicken))
        addChild(powerup3)
        powerup4.setScale(0.3)
        powerup4.zPosition = 2
        powerup4.alpha = 0.3
        powerup4.position = CGPoint(x: self.frame.midX + 90, y: self.frame.midY-350)
        powerup4.run(SKAction.repeatForever(aufdicken))
        addChild(powerup4)
        powerup5.setScale(0.3)
        powerup5.zPosition = 2
        powerup5.alpha = 0.3
        powerup5.position = CGPoint(x: self.frame.midX + 180, y: self.frame.midY-350)
        powerup5.run(SKAction.repeatForever(aufdicken))
        addChild(powerup5)
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        scene?.physicsWorld.gravity = CGVectorMake(0, 0)
        
        self.magicStick = SKEmitterNode(fileNamed: "MyParticle.sks")
        if let magicStick = self.magicStick {
            magicStick.particleTexture = SKTexture(imageNamed: "magicstick.png")
            magicStick.particleZPosition = 10
            magicStick.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
        }
        
        let userDefaults = UserDefaults.standard
        playerCoins = userDefaults.integer(forKey: scoreKey)
        playerFusil = userDefaults.integer(forKey: scoreFusil)
        playerPowerup = userDefaults.integer(forKey: scorePowerup)
        playerLaser = userDefaults.integer(forKey: scoreLaser)
        playerLevel = userDefaults.integer(forKey: scoreLevel)
        
        userDefaults.synchronize()
        
        let action = SKAction.setTexture(SKTexture(imageNamed: arrayFusil[playerFusil]), resize: true)
        self.player.run(action)
        
        player.position = CGPoint(x: 1000, y: 400)
        addChild(player)
        
        //Gegner
        let gegner = Gegner(type: playerLevel)
        gegner.setScale(0.8)
        let wait1 = SKAction.wait(forDuration: 1.0)
        let spawn = SKAction.run { self.addChild(gegner)}
        let sequence = SKAction.sequence([wait1, spawn])
        run(SKAction.repeat(sequence, count: 1))
        
        let gegnerWeapon = GegnerWeapon(type: playerLevel)
        gegnerWeapon.zPosition = 2
        gegnerWeapon.name = "gegnerWeapon"
        
        if playerLevel == 0 {   // Waage - Oktober
            gegner.position = CGPoint( x: 0, y: Int(size.height) - 150)
            gegner.wobble()
            gegner.moveAlong()
            
            let wait2 = SKAction.wait(forDuration: 8.0)
            let spawn2 = SKAction.run { self.spawnGegnerWeapon0()}
            let sequence2 = SKAction.sequence([wait2, spawn2])
            run(SKAction.repeatForever(sequence2))
        }
        else if playerLevel == 1 { // Skorpion - November
            gegner.position = CGPoint( x: 100, y: Int(size.height) - 150)
            gegner.rotate()
            gegner.moveToPlayerLeft()
            
            let wait2 = SKAction.wait(forDuration: 8.0)
            let spawn2 = SKAction.run { self.spawnGegnerWeapon1()}
            let sequence2 = SKAction.sequence([wait2, spawn2])
            run(SKAction.repeatForever(sequence2))
        }
        else if playerLevel == 2 {  // Schütze - Dezember
            gegner.position = CGPoint( x: 2000, y: Int(size.height) - 200)
            
            gegner.sagittarius()
            
            let wait2 = SKAction.wait(forDuration: 8.0)
            let spawn2 = SKAction.run { self.spawnGegnerWeapon2()}
            let sequence2 = SKAction.sequence([wait2, spawn2])
            run(SKAction.repeatForever(sequence2))

        }
        else if playerLevel == 3 { // Steinbock - Januar
            gegner.position = CGPoint( x: 2000, y: Int(size.height) - 100)
            let gegner2 = SKTexture(imageNamed: "capricorn1")
            let gegner1 = SKTexture(imageNamed: "capricorn2")
            let animation = SKAction.animate(with: [gegner2, gegner1], timePerFrame: 0.2)
            let makeGegner = SKAction.repeatForever(animation)
            gegner.run (makeGegner)
            gegner.step()
            gegner.moveToPlayerRight()
            
            let wait2 = SKAction.wait(forDuration: 8.0)
            let spawn2 = SKAction.run { self.spawnGegnerWeapon3()}
            let sequence2 = SKAction.sequence([wait2, spawn2])
            run(SKAction.repeatForever(sequence2))
        }
        else if playerLevel == 4{ // Wassermann - Februar
            gegner.position = CGPoint( x: 0, y: 950)
            gegner.wobble()
            gegner.moveDown()
            
            let wait2 = SKAction.wait(forDuration: 8.0)
            let spawn2 = SKAction.run { self.spawnGegnerWeapon4()}
            let sequence2 = SKAction.sequence([wait2, spawn2])
            run(SKAction.repeatForever(sequence2))
        }
        else if playerLevel == 5{ //Fische - März
            gegner.position = CGPoint( x: Int.random(in: 200 ..< 2400), y: Int(size.height))
            gegner.rotateFull()
            gegner.moveToPlayer()
            
            let wait2 = SKAction.wait(forDuration: 8.0)
            let spawn2 = SKAction.run { self.spawnGegnerWeapon5()}
            let sequence2 = SKAction.sequence([wait2, spawn2])
            run(SKAction.repeatForever(sequence2))
        }
        else if playerLevel == 6{ //Widder - April
            gegner.position = CGPoint( x: 1400, y: 1200)
            let gegner3 = SKTexture(imageNamed: "aries1")
            let gegner2 = SKTexture(imageNamed: "aries2")
            let gegner1 = SKTexture(imageNamed: "aries3")
            let animation = SKAction.animate(with: [gegner2, gegner1, gegner3], timePerFrame: 0.2)
            let makeGegner = SKAction.repeatForever(animation)
            gegner.run (makeGegner)
                    
            gegner.step()
            gegner.moveToPlayerRighttoLeft()
            
            let wait2 = SKAction.wait(forDuration: 8.0)
            let spawn3 = SKAction.run { self.spawnGegnerWeapon6()}
            let sequence2 = SKAction.sequence([wait2, spawn3])
            run(SKAction.repeatForever(sequence2))
        }
        else if playerLevel == 7{ //Stier - Mai
            gegner.position = CGPoint( x: 1000, y: 900)
            gegner.step()
            gegner.moveToPlayerRighttoLeft()
            
            let wait2 = SKAction.wait(forDuration: 8.0)
            let spawn3 = SKAction.run { self.spawnGegnerWeapon7()}
            let sequence2 = SKAction.sequence([wait2, spawn3])
            run(SKAction.repeatForever(sequence2))
        }
        else if playerLevel == 8{ // Zwillinge - Juni
            gegner.position = CGPoint( x: 0, y: 1000)
            gegner.wobble()
            gegner.dance()
            
            let wait2 = SKAction.wait(forDuration: 8.0)
            let spawn3 = SKAction.run { self.spawnGegnerWeapon8()}
            let sequence2 = SKAction.sequence([wait2, spawn3])
            run(SKAction.repeatForever(sequence2))
        }
        else if playerLevel == 9{ // Krebs - Juli
            gegner.position = CGPoint( x: Int.random(in: 500..<1400), y: 1500)
            let gegner2 = SKTexture(imageNamed: "cancer1")
            let gegner1 = SKTexture(imageNamed: "cancer2")
            let animation = SKAction.animate(with: [gegner2, gegner1], timePerFrame: 0.2)
            let makeGegner = SKAction.repeatForever(animation)
            gegner.run (makeGegner)
            gegner.wobblefast()
            gegner.moveCancer()
            
            let wait2 = SKAction.wait(forDuration: 8.0)
            let spawn2 = SKAction.run { self.spawnGegnerWeapon9()}
            let sequence2 = SKAction.sequence([wait2, spawn2])
            run(SKAction.repeatForever(sequence2))
        }
        else if playerLevel == 10{ // Löwe - August
            gegner.position = CGPoint( x: Int(size.width)-100, y: Int(size.height)-100)
            let gegner2 = SKTexture(imageNamed: "lion1")
            let gegner1 = SKTexture(imageNamed: "lion2")
            let animation = SKAction.animate(with: [gegner2, gegner1], timePerFrame: 0.2)
            let makeGegner = SKAction.repeatForever(animation)
            gegner.run (makeGegner)
            gegner.step()
            gegner.moveToPlayerRighttoLeft()
            
            let wait2 = SKAction.wait(forDuration: 8.0)
            let spawn2 = SKAction.run { self.spawnGegnerWeapon10()}
            let sequence2 = SKAction.sequence([wait2, spawn2])
            run(SKAction.repeatForever(sequence2))
        }
        else if playerLevel == 11{ // Jungfrau - September
            gegner.position = CGPoint( x: 0, y: 1000)
            gegner.wobble()
            gegner.moveAlong()
            
            let wait2 = SKAction.wait(forDuration: 8.0)
            let spawn2 = SKAction.run { self.spawnGegnerWeapon11()}
            let sequence2 = SKAction.sequence([wait2, spawn2])
            run(SKAction.repeatForever(sequence2))
        }
        else if playerLevel == 12{
            return
        }
    
        //COINNNSSSSSS
        let wait = SKAction.wait(forDuration: 4.0)
        let constantSpawn = SKAction.run { self.spawnCoins() }
        let spawnSequence = SKAction.sequence([wait, constantSpawn])
        run(SKAction.repeatForever(spawnSequence))
        
        //PowerUp
        let warte = SKAction.wait(forDuration: 10.0)
        let rein = SKAction.run { self.spawnPowerup() }
        let seq = SKAction.sequence([warte, rein])
        run(SKAction.repeatForever(seq))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            
            let location = touch.location(in: self)
            if let n = self.magicStick?.copy() as! SKEmitterNode? {
                n.position = location
                self.addChild(n)
            }
            let node = self.atPoint(location)
            
            if (node.name == "links") {
                let bla = SKAction.moveTo(x: player.position.x-200, duration: 0.3)
                bla.timingFunction = {
                    time in return simd_smoothstep(0, 1, time)
                }
                let blub = SKAction.moveTo(x: CGFloat(normalPlayerPositionX), duration: 2.0)
                blub.timingFunction = {
                    time in return simd_smoothstep(0, 1, time)
                }
                let sequence = SKAction.sequence([bla, blub])
                player.run(sequence)
                
            } else if (node.name == "rechts") {
                let bla = SKAction.moveTo(x: player.position.x+200, duration: 0.3)
                bla.timingFunction = {
                    time in return simd_smoothstep(0, 1, time)
                }
                let blub = SKAction.moveTo(x: CGFloat(normalPlayerPositionX), duration: 2.0)
                blub.timingFunction = {
                    time in return simd_smoothstep(0, 1, time)
                }
                let sequence = SKAction.sequence([bla, blub])
                player.run(sequence)
                
            } else if (node.name == "Powerups") {
                if playerPowerup > 0 {
                        run("sound-intro")
                        let blib = SKAction.moveTo(y: player.position.y+200, duration: 0.5)
                        blib.timingFunction = { time in return simd_smoothstep(0, 1, time) }
                        let blae = SKAction.moveTo(y: CGFloat(normalPlayerPositionY), duration: 2.0)
                        blae.timingFunction = { time in return simd_smoothstep(0, 1, time) }
                        let sequence = SKAction.sequence([blib, blae])
                        player.run(sequence)
                        playerPowerup -= 1
                } else {
                    return }
            } else if (node.name == "controlsLaser") {
                shootLaserBeam()
                run("sound-shotShort")
                zahl += 1
                if zahl == 2 {
                    if  dt < 0.017
                    {
                        shootLaserBeam()
                        shootLaserBeam()
                        shootLaserBeam()
                        shootLaserBeam()
                        shootLaserBeam()
                        shootLaserBeam()
                        zahl = 0
                    } else {return}
                    zahl -= 1
                }
            } else if (node.name == "Menu") {
                self.view?.presentScene(MenuScene(size: self.size),
                                        transition: .crossFade(withDuration: 2))
                run("sound-button")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in:self)
            if let n = self.magicStick?.copy() as! SKEmitterNode? {
                n.position = location
                self.addChild(n)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
           
        if (contactMask == 5) // player - gegner
        {
            if let explosion = SKEmitterNode(fileNamed: "particle-explosion"){
                    explosion.position = player.position
                    addChild(explosion)}
            run("sound-bomb")
            playerHearts -= 1
            gegnerHearts -= 1
            if contact.bodyA.node?.name == "gegner"{
                let bla = SKAction.moveTo(y: -500, duration: 0.02)
                contact.bodyA.node?.run(bla)
                }
            else {
                let bla = SKAction.moveTo(y: -500, duration: 0.05)
                contact.bodyB.node?.run(bla)}
            if playerHearts <= 0 {
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 3.0)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 3.0)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
                if contact.bodyA.node?.name == "gegner"{ contact.bodyA.node?.removeFromParent()}
                else {contact.bodyB.node?.removeFromParent()}
                player.removeFromParent()
                gameover()
            }
        }
        else if (contactMask == 6) // laser - gegner
        {
           if let explosion = SKEmitterNode(fileNamed: "particle-explosion"){
               if contact.bodyA.node?.name == "gegner"{
                   explosion.position = contact.bodyA.node?.position ?? CGPoint(x: 0, y: 0)}
               else {explosion.position = contact.bodyB.node?.position ?? CGPoint(x: 0, y: 0)}
                addChild(explosion)}
           gegnerHearts -= 1
           if gegnerHearts <= 0 {
                run("sound-GegnerDead")
                if contact.bodyA.node?.name == "gegner"{ contact.bodyA.node?.removeFromParent()}
                else {contact.bodyB.node?.removeFromParent()}
                let wait = SKAction.wait(forDuration: 0.5)
                let win = SKAction.run { self.won()}
                let sequence = SKAction.sequence([wait, win])
                run (sequence)
            }
        }
        else if (contactMask == 9) // player - gegnerWeapon
        {
            if let explosion = SKEmitterNode(fileNamed: "particle-explosion"){
                    explosion.position = contact.bodyA.node!.position
                    addChild(explosion)}
            run("sound-bomb")
            playerHearts -= 50
            if contact.bodyA.node?.name == "gegnerWeapon"{ contact.bodyA.node?.removeFromParent()}
            else {contact.bodyB.node?.removeFromParent()}
            if playerHearts <= 0 {
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 3.0)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 3.0)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
                player.removeFromParent()
                gameover()
            }
        }
        else if (contactMask == 10) // laser - gegnerWeapon
        {
                if let explosion = SKEmitterNode(fileNamed: "particle-explosion"){
                    explosion.position = laserBeam.position
                    addChild(explosion)}
                run("sound-bomb")
                gegnerHearts -= 1
                if gegnerHearts <= 0 {
                    run("sound-GegnerDead")
                    if contact.bodyA.node?.name == "gegner"{ contact.bodyA.node?.removeFromParent()}
                    else {contact.bodyB.node?.removeFromParent()}
                    let wait = SKAction.wait(forDuration: 0.5)
                    let win = SKAction.run { self.won()}
                    let sequence = SKAction.sequence([wait, win])
                    run (sequence)
                }
                if contact.bodyA.node?.name == "gegnerWeapon" { contact.bodyA.node?.removeFromParent()}
                else { contact.bodyB.node?.removeFromParent()}
        }
        else { print("keine ahnung") }
    }
    
    func spawnCoins() {
        let coin = SKSpriteNode(imageNamed: "objectCoin")
        coin.setScale(0.3)
        coin.zPosition = 2
        coin.name = "coin"
        coin.position = CGPoint( x: Int.random(in: 300 ..< 2300),
                                 y: Int(size.height) + 200)
        addChild(coin)
        
        let left = SKAction.rotate(byAngle: 3.14 / 8.0, duration: 0.5)
        let right = left.reversed()
        let wobble = SKAction.sequence([left, right])
        coin.run(SKAction.repeatForever(wobble))
        
       // let destination = CGPoint(x: Int.random(in: 10 ..< 1190), y: -200)
        let coinFall = SKAction.moveTo(y: -200, duration: 8)
        //let coinMove = SKAction.move(to: y: -200, duration: 8)//(to: destination, duration: 8)
        let coinRemove = SKAction.removeFromParent()
        
        let animation = SKAction.sequence([coinFall, coinRemove])
        coin.run(animation)
    }
    
    func spawnPowerup(){
        let powerup = SKSpriteNode(imageNamed: "objectPowerup")
        powerup.setScale(0.5)
        powerup.zPosition = 2
        powerup.name = "powerup"
        powerup.position = CGPoint( x: Int.random(in: 300 ..< 2300),
                                    y: Int(size.height) + 200)
        addChild(powerup)
        
        let dicker = SKAction.scale(to: 0.3, duration: 0.5)
        let dunner = SKAction.scale(to: 0.2, duration: 0.3)
        let aufdicken = SKAction.sequence([dicker, dunner])
        powerup.run(SKAction.repeatForever(aufdicken))
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: -1000))
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 100)
        let sequence = SKAction.sequence([movement, .removeFromParent()])
        powerup.run(sequence)
    }
    
    
    //Waage
    func spawnGegnerWeapon0() {
        let gegnerWeapon = GegnerWeapon(type: 0)
        let arrayWeapon = ["object10W", "object10X"]
        //SKSpriteNode(imageNamed: arrayWeapon[Int.random(in: 0..<1)])
        gegnerWeapon.position = CGPoint(x: Int.random(in: 400 ..< 2200), y: Int(size.height) + 100)
        gegnerWeapon.setScale(0.8)
        addChild(gegnerWeapon)
        
        gegnerWeapon.wobble()
        gegnerWeapon.randomCoin()
    }
    
    //Skorpion object11
    func spawnGegnerWeapon1() {
            let gegnerWeapon = GegnerWeapon(type: 1)
            gegnerWeapon.position = CGPoint(x: Int.random(in: 400 ..< 2200), y: Int(size.height) + 100)
            //gegnerWeapon.setScale(0.5)
            addChild(gegnerWeapon)
            
            gegnerWeapon.wobble()
            gegnerWeapon.randomCoin()
        }

    //Schütze
    func spawnGegnerWeapon2() {
        let gegnerWeapon = GegnerWeapon(type: 2)
            let arrayWeapon = ["object12W", "object12X", "object12Y"]
            //SKSpriteNode(imageNamed: arrayWeapon[Int.random(in: 0..<2)])
            gegnerWeapon.position = CGPoint(x: Int.random(in: 1500 ..< 1900), y: Int(size.height) + 20)
            
            gegnerWeapon.setScale(0.6)
            addChild(gegnerWeapon)
            
            gegnerWeapon.pfeile()
    }

    //Steinbock
    func spawnGegnerWeapon3() {
        let gegnerWeapon = GegnerWeapon(type: 3)
            gegnerWeapon.position = CGPoint(x: Int.random(in: 400 ..< 2200), y: Int(size.height) + 100)
            //gegnerWeapon.setScale(0.5)
            addChild(gegnerWeapon)
            
            gegnerWeapon.step()
            gegnerWeapon.randomCoin()
        }
    
    //Wassermann
    func spawnGegnerWeapon4() {
        let gegnerWeapon = GegnerWeapon(type: 4)
        let xPosition = Int.random(in: 1000 ..< 1600)
            gegnerWeapon.position = CGPoint(x: xPosition, y: Int(size.height) + 100)
           
            //gegnerWeapon.setScale(0.4)
            addChild(gegnerWeapon)
            
            gegnerWeapon.wobbleSanft()
            gegnerWeapon.hideLeft()
        }
    
    //Fische
    func spawnGegnerWeapon5() {
        let gegnerWeapon = GegnerWeapon(type: 5)
            gegnerWeapon.position = CGPoint(x: Int.random(in: 400 ..< 2200), y: Int(size.height) + 100)
           
            //gegnerWeapon.setScale(0.5)
            addChild(gegnerWeapon)
            
            gegnerWeapon.rotateFull()
            gegnerWeapon.randomCoin()
        }
    
    //Widder
    func spawnGegnerWeapon6() {
        let gegnerWeapon = GegnerWeapon(type: 6)
            //let gegnerWeapon = SKSpriteNode(imageNamed: "object4")
            gegnerWeapon.position = CGPoint(x: Int.random(in: 400 ..< 2200), y: Int(size.height) + 100)
           
            //gegnerWeapon.setScale(0.5)
            addChild(gegnerWeapon)
            
            gegnerWeapon.wobble()
            gegnerWeapon.randomCoin()
        }
    
    //Stier
    func spawnGegnerWeapon7() {
        let gegnerWeapon = GegnerWeapon(type: 7)
            //let gegnerWeapon = SKSpriteNode(imageNamed: "object5")
            gegnerWeapon.position = CGPoint(x: Int.random(in: 400 ..< 2200), y: Int(size.height) + 100)
            
            //gegnerWeapon.setScale(0.5)
            addChild(gegnerWeapon)
            
            gegnerWeapon.step()
            gegnerWeapon.randomCoin()
        }
    
    //ZWillinge
    func spawnGegnerWeapon8() {
        let gegnerWeapon = GegnerWeapon(type: 8)
            //let gegnerWeapon = SKSpriteNode(imageNamed: "object6W1")
            gegnerWeapon.position = CGPoint( x: 150, y: Int(size.height) - 650)
           
            //gegnerWeapon.setScale(0.6)
            addChild(gegnerWeapon)
            
        let gegnerWeapon1 = SKSpriteNode(imageNamed: "gemini2")
                gegnerWeapon1.zPosition = 2
                gegnerWeapon1.name = "gegner"
                gegnerWeapon1.position = CGPoint( x: Int(size.width)-150, y: Int(size.height) - 650)
                gegnerWeapon1.physicsBody = SKPhysicsBody(texture: gegnerWeapon1.texture!, size: gegnerWeapon1.texture!.size())
                gegnerWeapon1.physicsBody?.categoryBitMask = CollisionType.gegnerWeapon1.rawValue
                gegnerWeapon1.physicsBody?.collisionBitMask = CollisionType.player.rawValue | CollisionType.laserBeam.rawValue
                gegnerWeapon1.physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.laserBeam.rawValue
                gegnerWeapon1.physicsBody?.isDynamic = false
                gegnerWeapon1.setScale(0.6)
                addChild(gegnerWeapon1)
            
                let path = UIBezierPath()
                path.move(to: .zero)
                path.addCurve(to: CGPoint(x: 450, y: 300), controlPoint1: CGPoint(x: 100, y: 100), controlPoint2: CGPoint(x: 300, y: -200))
                let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 300)
                let sequence = SKAction.sequence([movement, .removeFromParent()])
                gegnerWeapon1.run (sequence)
            
                let path1 = UIBezierPath()
                path1.move(to: .zero)
                path1.addCurve(to: CGPoint(x: -500, y: 300), controlPoint1: CGPoint(x: -200, y: 200), controlPoint2: CGPoint(x: -400, y: -200))
                let movement1 = SKAction.follow(path1.cgPath, asOffset: true, orientToPath: true, speed: 300)
               
        let gegnerWeapon2 = SKSpriteNode(imageNamed: "gemini3")
                gegnerWeapon2.zPosition = 2
                gegnerWeapon2.name = "gegner"
                gegnerWeapon2.position = CGPoint( x: 2000, y: Int(size.height) - 650)
                gegnerWeapon2.physicsBody = SKPhysicsBody(texture: gegnerWeapon1.texture!, size: gegnerWeapon1.texture!.size())
                gegnerWeapon2.physicsBody?.categoryBitMask = CollisionType.gegnerWeapon1.rawValue
                gegnerWeapon2.physicsBody?.collisionBitMask = CollisionType.player.rawValue | CollisionType.laserBeam.rawValue
                gegnerWeapon2.physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.laserBeam.rawValue
                gegnerWeapon2.physicsBody?.isDynamic = false
                gegnerWeapon2.setScale(0.6)
                addChild(gegnerWeapon2)
            
                let path2 = UIBezierPath()
                path2.move(to: .zero)
                path2.addCurve(to: CGPoint(x: 450, y: 300), controlPoint1: CGPoint(x: 100, y: 100), controlPoint2: CGPoint(x: 300, y: -200))
                let movement2 = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 300)
                let sequence2 = SKAction.sequence([movement2, .removeFromParent()])
                gegnerWeapon2.run (sequence2)
            
                let path3 = UIBezierPath()
                path3.move(to: .zero)
                path3.addCurve(to: CGPoint(x: -500, y: 300), controlPoint1: CGPoint(x: -200, y: 200), controlPoint2: CGPoint(x: -400, y: -200))
                let movement3 = SKAction.follow(path3.cgPath, asOffset: true, orientToPath: true, speed: 300)
    }
    
    //Krebs
    func spawnGegnerWeapon9() {
        let gegnerWeapon = GegnerWeapon(type: 9)
        //let gegnerWeapon = SKSpriteNode(imageNamed: "object7")
        gegnerWeapon.position = CGPoint(x: Int.random(in: 400 ..< 2200), y: Int(size.height) + 100)
        //gegnerWeapon.setScale(0.5)
        addChild(gegnerWeapon)
        
        gegnerWeapon.wobble()
        gegnerWeapon.randomCoin()
    }
    
    //Löwe
    func spawnGegnerWeapon10() {
        let gegnerWeapon = GegnerWeapon(type: 10)
        //let gegnerWeapon = SKSpriteNode(imageNamed: "object8")
        gegnerWeapon.position = CGPoint(x: Int.random(in: 400 ..< 2200), y: Int(size.height) + 100)
        //gegnerWeapon.setScale(0.3)
        addChild(gegnerWeapon)
            
        gegnerWeapon.wobble()
        gegnerWeapon.randomCoin()
    }
    
    //Jungfrau
    func spawnGegnerWeapon11() {
        let gegnerWeapon = GegnerWeapon(type: 11)
        let weapon3 = SKTexture(imageNamed: "objectCoinBlue")
        let weapon2 = SKTexture(imageNamed: "objectCoinGreen")
        let weapon1 = SKTexture(imageNamed: "objectCoinPink")
        let animation = SKAction.animate(with: [weapon1, weapon2, weapon3], timePerFrame: 0.2)
        let makeWeapon = SKAction.repeatForever(animation)
        gegnerWeapon.run (makeWeapon)
        gegnerWeapon.position = CGPoint(x: Int.random(in: 400 ..< 2200), y: Int(size.height) + 100)
        gegnerWeapon.setScale(0.3)
        addChild(gegnerWeapon)
           
        gegnerWeapon.wobble()
        gegnerWeapon.randomCoin()
        }
    
    
    func shootLaserBeam() {
        let laserBeam = SKSpriteNode(imageNamed: arrayLaser[playerLaser])
       
            laserBeam.zPosition = 1
            laserBeam.setScale(1)
            laserBeam.name = "laserBeam"
            laserBeam.position = player.position
        
            laserBeam.physicsBody = SKPhysicsBody(texture: laserBeam.texture!, size: laserBeam.texture!.size())
            laserBeam.physicsBody?.contactTestBitMask = ColliderType.gegner.rawValue | ColliderType.gegnerWeapon.rawValue
            laserBeam.physicsBody?.categoryBitMask  = ColliderType.laserBeam.rawValue
            laserBeam.physicsBody?.collisionBitMask = ColliderType.laserBeam.rawValue
            addChild(laserBeam)
        
        if playerLaser == 0{
            let move = SKAction.moveBy(x: 0, y: size.height, duration: 0.4)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, remove])
            laserBeam.run(sequence)
        }
        else if playerLaser == 1{
            let move = SKAction.moveBy(x: 0, y: size.height, duration: 0.3)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, remove])
            laserBeam.run(sequence)
        }
        else if playerLaser == 2{
            let move = SKAction.moveBy(x: 0, y: size.height, duration: 0.2)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, remove])
            laserBeam.run(sequence)
        }
        else if playerLaser == 3{
            let move = SKAction.moveBy(x: 0, y: size.height, duration: 0.2)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, remove])
            laserBeam.run(sequence)
        } else { return }
      }
    
    func checkForCoins() {
        enumerateChildNodes(withName: "coin") { node, _ in
            let coin = node as! SKSpriteNode
            if coin.frame.intersects(self.player.frame) {
                self.playerCoins += 1
                self.run("sound-Coin")
                coin.removeFromParent()
            }
        }
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
       if self.playerPowerup == 0 {powerup1.alpha = 0.0 } else {powerup1.alpha = 1.0}
       if self.playerPowerup <= 1 {powerup2.alpha = 0.0 } else {powerup2.alpha = 1.0}
       if self.playerPowerup <= 2 {powerup3.alpha = 0.0 } else {powerup3.alpha = 1.0}
       if self.playerPowerup <= 3 {powerup4.alpha = 0.0 } else {powerup4.alpha = 1.0}
       if self.playerPowerup <= 4 {powerup5.alpha = 0.0 } else {powerup5.alpha = 1.0}
       
    }
    func checkHearts(){
        if playerHearts <= 2000 { battery0.alpha = 1.0} else {battery0.alpha = 0.0}
        if playerHearts <= 1600 { battery1.alpha = 1.0} else {battery1.alpha = 0.0}
        if playerHearts <= 1200 { battery2.alpha = 1.0} else {battery2.alpha = 0.0}
        if playerHearts <= 800 { battery3.alpha = 1.0} else {battery3.alpha = 0.0}
        if playerHearts <= 400 { battery4.alpha = 1.0} else {battery4.alpha = 0.0}
        if playerHearts <= 0 { battery5.alpha = 1.0} else {battery5.alpha = 0.0}
    }
    func checkGegnerHearts(){
        if gegnerHearts <= 2000 { batteryG0.alpha = 1.0} else {batteryG0.alpha = 0.0}
        if gegnerHearts <= 1600 { batteryG1.alpha = 1.0} else {batteryG1.alpha = 0.0}
        if gegnerHearts <= 1200 { batteryG2.alpha = 1.0} else {batteryG2.alpha = 0.0}
        if gegnerHearts <= 800 { batteryG3.alpha = 1.0} else {batteryG3.alpha = 0.0}
        if gegnerHearts <= 400 { batteryG4.alpha = 1.0} else {batteryG4.alpha = 0.0}
        if gegnerHearts <= 0 { batteryG5.alpha = 1.0} else {batteryG5.alpha = 0.0}
    }
    override func update(_ currentTime: TimeInterval) {
        checkHearts()
        checkGegnerHearts()
        scoreCoins.text = "\(playerCoins)"
        labelplayerHearts.text = "\(playerHearts)"
        labelgegnerHearts.text = "\(gegnerHearts)"
        
        player.boundsCheckPlayer()
        checkForCoins()
        checkForPowerups()
        powerupMenu()
        
        let defaults = UserDefaults.standard
        defaults.set(playerCoins, forKey: scoreKey)
        defaults.set(playerPowerup, forKey: scorePowerup)
        defaults.set(playerLaser, forKey: scoreLaser)
        defaults.set(playerLevel, forKey: scoreLevel)
   
        if lastUpdateTime > 0 {dt = currentTime - lastUpdateTime}
        else {dt = 0}
        lastUpdateTime = currentTime
        
        print ("\(playerLevel)")
    }
    
    func won(){
        //playerLevel += 1
        priceCoins.text = "+50 !!!"
        let fadein = SKAction.fadeAlpha(to: 1.0, duration: 3.0)
        let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 3.0)
        let seq = SKAction.sequence([fadein, fadeout])
        priceCoins.run(seq)
        playerCoins += 50
      
        if let geldregen = SKEmitterNode(fileNamed: "particle-geldregen"){
            geldregen.position = CGPoint(x: 1300, y: 1000)
            addChild(geldregen)}
        
        run("sound-won")
        removeAllActions()
        gegner.hide()
        let won = SKSpriteNode(imageNamed: "won")
        won.position = CGPoint(x: self.frame.midX, y: self.frame.midY+300)
        won.setScale(3)
        won.zPosition = 5
        addChild(won)
    }
    
    func gameover(){
        battery5.alpha = 1.0
        priceCoins.text = "-20 !"
        playerCoins -= 20
        run("sound-lost")
        removeAllActions()
        gegner.hide()
        let gameover = SKSpriteNode(imageNamed: "gameOver")
        gameover.position = CGPoint(x: self.frame.midX, y: self.frame.midY+300)
        gameover.setScale(3)
        gameover.zPosition = 5
        addChild(gameover)
    }
    
    
    func run(_ fileName: String){
               run(SKAction.playSoundFileNamed(fileName, waitForCompletion: true))
           
       }
}
