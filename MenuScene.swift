//
//  MenuScene.swift
//  StarGlow
//
//  Created by Valerie on 30.03.23.
//

import SpriteKit
import GameplayKit
import UIKit

//more noises click clack uhr die aufgezogen wird

class MenuScene: SKScene {
    
    static var sound = true
    public let bgSound = SKAudioNode(fileNamed: "astrowing fadeinandout")
    
    var disc = SKSpriteNode(imageNamed: "discMenu1")
    var zahl = 0
    
    var scoreCoins: SKLabelNode!
    
    private var magicStick : SKEmitterNode?
    
    var touchLocation = CGPoint()
    var startTouch = CGPoint()
    var endTouch = CGPoint()

    var startingAngle = 6.24
    var startingTime:TimeInterval?
    
    var playerCoins = Int()
    let scoreKey = "scoreKey"
    var playerFusil = 0
    let scoreFusil = "scoreFusil"
    var wayPoints = [CGPoint]()
    let scoreDraw = "scoreDraw"
   
    var playerLevel = Int()
    let scoreLevel = "scoreLevel"
    
    var labelGarageExplained = SKLabelNode()
    var labelMonthExplained = SKLabelNode()
    
    //var playerName: SKLabelNode!
    //let scoreName = "scoreName"
    
    let arrayFusil = ["fusil00", "fusil00Wblack", "fusil00Wblue", "fusil00Wcyan", "fusil00Wgreen", "fusil00Worange", "fusil00Wpink", "fusil011", "fusil012", "fusil013", "fusil014", "fusil015", "fusil016", "fusil017", "fusil021", "fusil022", "fusil023", "fusil024"]
    
    let player = Player()
    
    override func didMove(to view: SKView) {

        self.magicStick = SKEmitterNode(fileNamed: "MyParticle.sks")
        if let magicStick = self.magicStick {
            magicStick.particleTexture = SKTexture(imageNamed: "magicstick.png")
            magicStick.particleZPosition = 10
            magicStick.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
        }
        
        let userDefaults = UserDefaults.standard
        playerCoins = userDefaults.integer(forKey: scoreKey)
        playerFusil = userDefaults.integer(forKey: scoreFusil)
        playerLevel = userDefaults.integer(forKey: scoreLevel)

        //playerName = userDefaults.value(forKey: scoreName) as? SKLabelNode
        //userDefaults.set(wayPoints, forKey: scoreDraw)
        userDefaults.synchronize()
        
       
        let backgroundImage = SKSpriteNode(imageNamed: "BgMenu")
        backgroundImage.size = CGSize(width: self.frame.width, height: self.frame.height + 500) //CGSize(width: 2048, height: 1536)
        backgroundImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 200)
        //backgroundImage.scaleMode = .aspectFill
        backgroundImage.zPosition = 2
        backgroundImage.isUserInteractionEnabled = false
        addChild(backgroundImage)
        
        /*
        playerName = SKLabelNode(fontNamed: "Chalkduster")
        playerName.setScale(2)
        playerName.zPosition = 5
        playerName.text = "\(playerName)"
        playerName.position = CGPoint(x: self.frame.midX+500, y: self.frame.midY+420)
        addChild(playerName)
        */
        
        let play = SKSpriteNode(imageNamed: "buttonPlay.jpg")
        play.name = "play"
        play.zPosition = 5
        play.position = CGPoint(x: self.frame.midX + 1070, y: self.frame.midY - 267)
        play.setScale(0.50)
        self.addChild(play)
        let drehlinks = SKAction.rotate(byAngle: -0.3, duration: 0.05)
        let drehrechts = SKAction.rotate(byAngle: 0.3, duration: 1.0)
        let warten = SKAction.wait(forDuration: 5.0)
        let seq = SKAction.sequence([drehrechts, drehlinks, warten])
        play.run(SKAction.repeatForever(seq))
        
        let garage = SKSpriteNode(imageNamed: "buttonGarage.jpg")
        garage.name = "garage"
        garage.zPosition = 5
        garage.position = CGPoint(x: self.frame.midX+700, y: self.frame.midY-450)
        garage.setScale(0.5)
        self.addChild(garage)
        let mi = SKAction.rotate(byAngle: -0.1, duration: 0.05)
        let ma = SKAction.rotate(byAngle: 0.1, duration: 1.0)
        let mu = SKAction.wait(forDuration: 7.0)
        let sequ = SKAction.sequence([ma, mi, mu])
        garage.run(SKAction.repeatForever(sequ))
        
        player.position = CGPoint(x: self.frame.midX + 460, y: self.frame.midY + 400)
        player.zPosition = 5
        player.name = "player"
        player.setScale(0.5)
        addChild(player)
        let action = SKAction.setTexture(SKTexture(imageNamed: arrayFusil[playerFusil]), resize: true)
        self.player.run(action)
        
        let left = SKAction.rotate(byAngle: 0.1, duration: 0.03)
        let right = SKAction.rotate(byAngle: -0.1, duration: 0.03)
        let wait = SKAction.wait(forDuration: 4.0)
        let wobble = SKAction.sequence([left, right, left, right, left, right, wait])
        player.run(SKAction.repeatForever(wobble))
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: -500))
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 180)
        let pith = UIBezierPath()
        pith.move(to: .zero)
        pith.addLine(to: CGPoint(x: 0, y: 500))
        let back = SKAction.follow(pith.cgPath, asOffset: true, orientToPath: true, speed: 180)
        let blablub = SKAction.sequence([movement, wait, back, wait])
        player.run(SKAction.repeatForever(blablub))
        
        let disc = SKShapeNode(circleOfRadius: 230)
        disc.name = "disc"
        disc.zPosition = 5
        disc.strokeColor = .init(white: 1.0, alpha: 0.5)
        disc.position = CGPoint(x: self.frame.midX - 1060, y: self.frame.midY-270)
        self.addChild(disc)
       
        if let twinkle = SKEmitterNode(fileNamed: "particle-explosion"){
            twinkle.position = disc.position
            twinkle.particleTexture = SKTexture(imageNamed: "particle-star")
            twinkle.zPosition = 7
            addChild(twinkle)
        }
        
        let draw = SKSpriteNode(imageNamed: "buttonDraw.jpg")
        draw.name = "draw"
        draw.zPosition = 5
        draw.position = CGPoint(x: self.frame.midX-700, y: self.frame.midY-450)
        draw.setScale(0.4)
        self.addChild(draw)
        let links = SKAction.rotate(byAngle: 0.3, duration: 0.05)
        let rechts = SKAction.rotate(byAngle: -0.3, duration: 1.0)
        let warte = SKAction.wait(forDuration: 4.0)
        let turn = SKAction.sequence([rechts, links, warte])
        draw.run(SKAction.repeatForever(turn))
        
        let music = SKSpriteNode(imageNamed: "buttonPlay.jpg")
        music.name = "music"
        music.zPosition = 5
        music.position = CGPoint(x: self.frame.maxX-100, y: self.frame.maxY-100)
        music.setScale(0.2)
        self.addChild(music)
        let linkss = SKAction.rotate(byAngle: 0.3, duration: 0.05)
        let rechtss = SKAction.rotate(byAngle: -0.3, duration: 1.0)
        let wartes = SKAction.wait(forDuration: 4.0)
        let turns = SKAction.sequence([rechtss, linkss, wartes])
        music.run(SKAction.repeatForever(turns))
        
        beginBGMusic(file: bgSound)
        
        spawnDisc()
        
        let invisible = SKShapeNode(rectOf: CGSize(width: 800, height: 200))
        invisible.position = CGPoint(x: self.frame.midX, y: self.frame.midY-350)
        invisible.strokeColor = .init(white: 1.0, alpha: 0.0)
        invisible.name = "Month"
        invisible.zPosition = 6
        addChild(invisible)
        
        if playerCoins < 0 { playerCoins = 0}
        scoreCoins = SKLabelNode(fontNamed: "Chalkduster")
        scoreCoins.setScale(2.0)
        scoreCoins.zPosition = 5
        scoreCoins.text = "\(playerCoins) "
        scoreCoins.position = CGPoint(x: self.frame.minX + 400, y: self.frame.maxY - 130)
        addChild(scoreCoins)
        
        //navibar:
        let coins = SKSpriteNode(imageNamed: "objectCoin.jpg")
        coins.position = CGPoint(x: self.frame.minX + 200, y: self.frame.maxY - 100)
        coins.setScale(0.3)
        coins.zPosition = 5
        addChild(coins)
        
        labelGarageExplained = SKLabelNode(fontNamed: "Chalkduster")
        labelGarageExplained.setScale(2.0)
        labelGarageExplained.zPosition = 5
        labelGarageExplained.text = "Garage ->"
        labelGarageExplained.position = CGPoint(x: self.frame.midX+300, y: self.frame.minY + 100)
        addChild(labelGarageExplained)
        
        labelMonthExplained = SKLabelNode(fontNamed: "Chalkduster")
        labelMonthExplained.setScale(2.0)
        labelMonthExplained.zPosition = 5
        labelMonthExplained.text = "> Turn to fav Month <"
        labelMonthExplained.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 400)
        addChild(labelMonthExplained)
        
        let wait1 = SKAction.wait(forDuration: 5)
        let fadeOut = SKAction.fadeOut(withDuration: 0.4)
        let fadeIn = SKAction.fadeIn(withDuration: 0.4)
        let seq1 = SKAction.sequence([fadeOut, wait1, fadeIn, wait1])
        let achja = SKAction.repeatForever(seq1)
        labelGarageExplained.run(achja)
        labelMonthExplained.run(achja)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
                    startTouch = touch.location(in:self)
                }
            guard var touch = touches.first else {return}
            touch = (touches.first as UITouch?)!
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if node.name == "music" {
                //stop()
            }
        
            if node.name == "play" {
                run("sound-button")
                if zahl == 0 {
                        playerLevel = 0
                        let defaults = UserDefaults.standard
                        defaults.set(0, forKey: scoreLevel)
                        self.view?.presentScene(Scene0(size: self.size),
                        transition: .crossFade(withDuration: 2))
                } else if zahl == 1 {
                        playerLevel = 1
                        let defaults = UserDefaults.standard
                        defaults.set(1, forKey: scoreLevel)
                        self.view?.presentScene(Scene0(size: self.size),
                        transition: .crossFade(withDuration: 2))
                } else if zahl == 2 {
                        playerLevel = 2
                        let defaults = UserDefaults.standard
                        defaults.set(2, forKey: scoreLevel)
                        self.view?.presentScene(Scene0(size: self.size),
                        transition: .crossFade(withDuration: 2))
                } else if zahl == 3 {
                        playerLevel = 3
                        let defaults = UserDefaults.standard
                        defaults.set(3, forKey: scoreLevel)
                        self.view?.presentScene(Scene0(size: self.size),
                        transition: .crossFade(withDuration: 2))
                } else if zahl == 4 {
                        playerLevel = 4
                        let defaults = UserDefaults.standard
                        defaults.set(4, forKey: scoreLevel)
                        self.view?.presentScene(Scene0(size: self.size),
                        transition: .crossFade(withDuration: 2))
                } else if zahl == 5 {
                        playerLevel = 5
                        let defaults = UserDefaults.standard
                        defaults.set(5, forKey: scoreLevel)
                        self.view?.presentScene(Scene0(size: self.size),
                        transition: .crossFade(withDuration: 2))
                } else if zahl == 6 {
                        playerLevel = 6
                        let defaults = UserDefaults.standard
                        defaults.set(6, forKey: scoreLevel)
                        self.view?.presentScene(Scene0(size: self.size),
                        transition: .crossFade(withDuration: 2))
                } else if zahl == 7 {
                        playerLevel = 7
                        let defaults = UserDefaults.standard
                        defaults.set(7, forKey: scoreLevel)
                        self.view?.presentScene(Scene0(size: self.size),
                        transition: .crossFade(withDuration: 2))
                } else if zahl == 8 {
                        playerLevel = 8
                        let defaults = UserDefaults.standard
                        defaults.set(8, forKey: scoreLevel)
                        self.view?.presentScene(Scene0(size: self.size),
                        transition: .crossFade(withDuration: 2))
                } else if zahl == 9 {
                        playerLevel = 9
                        let defaults = UserDefaults.standard
                        defaults.set(9, forKey: scoreLevel)
                        self.view?.presentScene(Scene0(size: self.size),
                        transition: .crossFade(withDuration: 2))
                } else if zahl == 10 {
                        playerLevel = 10
                        let defaults = UserDefaults.standard
                        defaults.set(10, forKey: scoreLevel)
                        self.view?.presentScene(Scene0(size: self.size),
                        transition: .crossFade(withDuration: 2))
                } else if zahl == 11 {
                        playerLevel = 11
                        let defaults = UserDefaults.standard
                        defaults.set(11, forKey: scoreLevel)
                        self.view?.presentScene(Scene0(size: self.size),
                        transition: .crossFade(withDuration: 2))
                } else {return}
            }
            if node.name == "player" {
                let left = SKAction.rotate(byAngle: 0.628, duration: 0.2)
                let right = SKAction.rotate(byAngle: -0.349, duration: 0.1)
                let wobble = SKAction.sequence([left, right, left])
                player.run(SKAction.repeat(wobble, count: 1))
                run("sound-bomb")
            }
            if node.name == "name"{
                print("tipppteil")
            }
            if node.name == "garage" {
                self.view?.presentScene(GarageScene(size: self.size),
                transition: .crossFade(withDuration: 2))
                run("sound-button")
            }
            if node.name == "disc" {
                self.view?.presentScene(DiscScene(size: self.size),
                transition: .crossFade(withDuration: 2))
                run("sound-button")
            }
            if node.name == "draw" {
                self.view?.presentScene(DrawScene(size: self.size),
                transition: .crossFade(withDuration: 2))
                run("sound-button")
            }
            if node.name == "Month" {
                let drehen = SKAction.rotate(byAngle: 3.14/6, duration: 1)
                disc.run(drehen)
                if zahl == 0 { zahl+=1 }
                else if zahl == 1 { zahl+=1 }
                else if zahl == 2 { zahl+=1 }
                else if zahl == 3 { zahl+=1 }
                else if zahl == 4 { zahl+=1 }
                else if zahl == 5 { zahl+=1 }
                else if zahl == 6 { zahl+=1 }
                else if zahl == 7 { zahl+=1 }
                else if zahl == 8 { zahl+=1 }
                else if zahl == 9 { zahl+=1 }
                else if zahl == 10 { zahl+=1 }
                else if zahl == 11 { zahl = 0 }
    
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
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
               for touch in touches {
                   endTouch = touch.location(in: self)
               }
           }
    
    override func update(_ currentTime: TimeInterval) {
        scoreCoins.text = "\(playerCoins)"
        
        let defaults = UserDefaults.standard
        defaults.set(playerCoins, forKey: scoreKey)
        defaults.set(playerLevel, forKey: scoreLevel)
        //defaults.set(playerName, forKey: scoreName)
        defaults.set(playerFusil, forKey: scoreFusil)
        
    }
    
    func spawnDisc(){
        disc.zPosition = 1
        disc.size = CGSize(width: 2500, height: 2500)
        disc.name = "disc"
        disc.physicsBody = SKPhysicsBody(circleOfRadius: 16)
        disc.physicsBody?.affectedByGravity = false
        disc.physicsBody?.isDynamic = true
           // Change this property as needed (increase it to slow faster)
        disc.physicsBody!.angularDamping = 4
        disc.physicsBody?.pinned = true
        disc.position = CGPointMake(self.frame.midX, self.frame.midY+800)
        self.addChild(disc)
    }
    
  
    func run(_ fileName: String){
               run(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
       }
    /*
    class func playSoundFileNamed(
        _ soundFile: String,
        waitForCompletion wait: Bool
    ) -> SKAction
    */
    
   /*
    func stop(){
        SKAction.playSoundFileNamed()
    }
    class func stop() -> SKAction*/
    
    
    
    func beginBGMusic(file: SKAudioNode) {
        file.autoplayLooped = true
                if MenuScene.sound == true {
                    scene?.addChild(file)
           } else {
               scene?.removeFromParent()
           }
       }
    
    
}
