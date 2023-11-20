//
//  GameScene.swift
//  AstroKid2
//
//  Created by Valerie on 10.07.23.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var magicStick : SKEmitterNode?
    
    //Einleitung
    var currentTouchPosition: CGPoint  = CGPointZero
    var beginningTouchPosition:CGPoint = CGPointZero
    var currentPlayerPosition: CGPoint = CGPointZero
    
    let starmap = SKSpriteNode(imageNamed: "discOldSignsNeon")
    let play = SKSpriteNode(imageNamed: "buttonGo")
    let starmap1 = SKSpriteNode(imageNamed: "discIntro")
    
    //MENU
    let playButton = SKSpriteNode(imageNamed: "buttonPlay.jpg")
    let garage = SKSpriteNode(imageNamed: "buttonGarage.jpg")
    let draw = SKSpriteNode(imageNamed: "buttonDraw.jpg")
    var disc = SKSpriteNode(imageNamed: "discMenu1")
    let coins = SKSpriteNode(imageNamed: "objectCoin.jpg")
    var zahl = 0
       
    var scoreCoins: SKLabelNode!
       
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
      
    let arrayFusil = ["fusil00", "fusil00Wblack", "fusil00Wblue", "fusil00Wcyan", "fusil00Wgreen", "fusil00Worange", "fusil00Wpink", "fusil011", "fusil012", "fusil013", "fusil014", "fusil015", "fusil016", "fusil017", "fusil021", "fusil022", "fusil023", "fusil024"]
       
    let player = Player()
    
    override func didMove(to view: SKView) {
        
        self.magicStick = SKEmitterNode(fileNamed: "MyParticle.sks")
        if let magicStick = self.magicStick {
            magicStick.particleTexture = SKTexture(imageNamed: "magicstick.png")
            magicStick.particleZPosition = 10
            magicStick.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
        }
        
        let backgroundImage = SKSpriteNode(imageNamed: "BgMenu")
        backgroundImage.size = CGSize(width: self.frame.width, height: self.frame.height + 500)//CGSize(width: 2048, height: 1536)
        backgroundImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 130)
        backgroundImage.zPosition = -20
        addChild(backgroundImage)
        
        //INTRO
        starmap.size = CGSize(width: 2000, height: 2000)
        starmap.position = CGPoint(x: self.frame.midX, y: self.frame.midY+650)
        starmap.zPosition = -26
        addChild(starmap)
        let reindrehen = SKAction.rotate(byAngle: -3.14, duration: 100)
        let ausblenden = SKAction.fadeOut(withDuration: 0.5)
        let beides = SKAction.sequence([reindrehen, ausblenden])
        starmap.run(beides)

        let einblenden = SKAction.fadeIn(withDuration: 5.5)
        starmap1.setScale(1)
        starmap1.position = CGPoint(x: self.frame.midX, y: self.frame.midY+600)
        starmap1.zPosition = -25
        starmap1.alpha = 0.0
        addChild(starmap1)
        starmap1.run(einblenden)
        
        run("intro-astrowing")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            self.view?.presentScene(MenuScene(size: self.size),
                                    transition: .crossFade(withDuration: 0.2))
        }
        /*
        play.name = "Menu"
        play.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 300)
        play.setScale(1.2)
        addChild(play)
        play.run(einblenden)*/

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
                    beginningTouchPosition = touch.location(in:self)
                    currentTouchPosition = beginningTouchPosition
                }
        guard var touch = touches.first else {return}
        touch = (touches.first as UITouch?)!
        let location = touch.location(in: self)
        let node = self.atPoint(location)
    
       
        /*if node.name == "Menu" {
                /* if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                */
                self.view?.presentScene(MenuScene(size: self.size),
                transition: .crossFade(withDuration: 2))
                //MenuScene.scaleMode = .aspectFill
                run("sound-button")
        }
        */
        
        if let n = self.magicStick?.copy() as! SKEmitterNode? {
                   n.position = location
                   self.addChild(n)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
                    currentTouchPosition = touch.location(in:self)
                }
        
                if let n = self.magicStick?.copy() as! SKEmitterNode? {
                    n.position = currentTouchPosition
                    self.addChild(n)
                }
    }
    
    override func update(_ currentTime: TimeInterval) {
           
    }
    
    
    func run(_ fileName: String){
               run(SKAction.playSoundFileNamed(fileName, waitForCompletion: true))
           
       }
}

