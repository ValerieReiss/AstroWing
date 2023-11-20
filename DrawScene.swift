//
//  DrawScene.swift
//  StarGlow
//
//  Created by Valerie on 29.03.23.
//


import SpriteKit
import GameplayKit

class DrawScene: SKScene {
    var currentTouchPosition: CGPoint  = CGPointZero
    var beginningTouchPosition:CGPoint = CGPointZero
    var currentPlayerPosition: CGPoint = CGPointZero

    var labelPlay = SKLabelNode()
    let scoreKey = "scoreKey"
    var playerFusil = 0
    let scoreFusil = "scoreFusil"
    
    let arrayFusil = ["fusil00", "fusil00Wblack", "fusil00Wblue", "fusil00Wcyan", "fusil00Wgreen", "fusil00Worange", "fusil00Wpink", "fusil011", "fusil012", "fusil013", "fusil014", "fusil015", "fusil016", "fusil017", "fusil021", "fusil022", "fusil023", "fusil024"]
    
    let player = Player()
    var wayPoints = [CGPoint]()
    var shapeNode = SKShapeNode()
    //let scoreDraw = "scoreDraw"
    
    override func didMove(to view: SKView) {
        let userDefaults = UserDefaults.standard
        playerFusil = userDefaults.integer(forKey: scoreFusil)
        //userDefaults.set(wayPoints, forKey: scoreDraw)
        //wayPoints = userDefaults.mutableArrayValue(forKeyPath: scoreDraw) as! [CGPoint]
        userDefaults.synchronize()
       
        labelPlay = SKLabelNode(fontNamed: "Chalkduster")
        labelPlay.fontSize = 60
        labelPlay.zPosition = 10
        labelPlay.color = .white
        labelPlay.position = CGPoint(x: self.frame.minX + 300, y: self.frame.maxY - 150)
        labelPlay.text = "Draw something"
        addChild(labelPlay)
      
        if let farEmitter = SKEmitterNode(fileNamed: "StarfieldFar.sks"){
            farEmitter.position = CGPoint(x: frame.width / 2, y: frame.height * 1.75)
            farEmitter.zPosition = 5
            farEmitter.advanceSimulationTime(180)
            addChild(farEmitter)
        }
        
        let backgroundImage = SKSpriteNode(imageNamed: "bgDrawCircle")
        backgroundImage.size = CGSize(width: self.frame.width, height: self.frame.height)
        backgroundImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        backgroundImage.zPosition = 4
        addChild(backgroundImage)
        
        let starmap = SKSpriteNode(imageNamed: "bgWhois")
        starmap.size = CGSize(width: 1700, height: 1700)
        starmap.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        starmap.zPosition = -6
        addChild(starmap)
     
        if wayPoints.count > 0 { }
        
//DRAW AREAAAAAA
        let drawArea = SKShapeNode(circleOfRadius: 500)
        drawArea.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        drawArea.strokeColor = .init(white: 1.0, alpha: 0.0)
        drawArea.name = "drawArea"
        drawArea.zPosition = 5
        addChild(drawArea)

        let buttonCyan = SKSpriteNode(imageNamed: "drawColorGreen")
        buttonCyan.name = "buttonCyan"
        buttonCyan.position = CGPoint(x: self.frame.maxX - 200, y: self.frame.maxY - 600)
        buttonCyan.zPosition = 6
        buttonCyan.setScale(0.5)
        self.addChild(buttonCyan)
        
        let buttonYellow = SKSpriteNode(imageNamed: "drawColorYellow")
        buttonYellow.name = "buttonYellow"
        buttonYellow.position = CGPoint(x: self.frame.maxX - 200, y: self.frame.maxY - 400)
        buttonYellow.zPosition = 6
        buttonYellow.setScale(0.5)
        self.addChild(buttonYellow)
        
        let buttonPink = SKSpriteNode(imageNamed: "drawColorPink")
        buttonPink.name = "buttonPink"
        buttonPink.position = CGPoint(x: self.frame.maxX - 200, y: self.frame.maxY - 200)
        buttonPink.zPosition = 6
        buttonPink.setScale(0.5)
        self.addChild(buttonPink)
        
        let buttonEraser = SKSpriteNode(imageNamed: "drawColorEraser")
        buttonEraser.name = "buttonEraser"
        buttonEraser.position = CGPoint(x: self.frame.maxX - 200, y: self.frame.midY - 420)
        buttonEraser.zPosition = 6
        buttonEraser.setScale(0.5)
        self.addChild(buttonEraser)
        
    //Player
        let action = SKAction.setTexture(SKTexture(imageNamed: arrayFusil[playerFusil]), resize: true)
        self.player.run(action)
        player.position = CGPoint(x: self.frame.midX-150, y: self.frame.midY)
        player.name = "player"
        player.zPosition = 10
        player.setScale(0.5)
        addChild(player)
        let left = SKAction.rotate(byAngle: 0.1, duration: 0.03)
        let right = SKAction.rotate(byAngle: -0.1, duration: 0.03)
        let wait = SKAction.wait(forDuration: 3.0)
        let wobble = SKAction.sequence([left, right, left, right, left, right, wait])
        player.run(SKAction.repeatForever(wobble))
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: -100, y: +300))
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 180)
        let pith = UIBezierPath()
        pith.move(to: .zero)
        pith.addLine(to: CGPoint(x: 100, y: -300))
        let back = SKAction.follow(pith.cgPath, asOffset: true, orientToPath: true, speed: 180)
        let blablub = SKAction.sequence([movement, wait, back, wait])
        player.run(SKAction.repeatForever(blablub))
        
    //Menu
        let menu = SKSpriteNode(imageNamed: "buttonLittle.jpg")
        menu.name = "Menu"
        menu.zPosition = 5
        menu.position = CGPoint(x: self.frame.minX + 240, y: self.frame.minY + 240)
        menu.setScale(0.3)
        self.addChild(menu)
       
        createPath()
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
        
        if node.name == "player" {
            let left = SKAction.rotate(byAngle: 0.628, duration: 0.2)
            let right = SKAction.rotate(byAngle: -0.349, duration: 0.1)
            let wobble = SKAction.sequence([left, right, left])
            player.run(SKAction.repeat(wobble, count: 1))
            run("sound-bomb")
        }
        
        if node.name == "Menu" {
                self.view?.presentScene(MenuScene(size: self.size),
                transition: .crossFade(withDuration: 4))
                run("sound-button")
                }
        if node.name == "drawArea" {
            wayPoints.append(beginningTouchPosition)
            redrawPath()
            shapeNode.alpha = 1
        }
        
        if node.name == "buttonPink"{
            run("sound-button")
            shapeNode.strokeColor = UIColor(red: 1.0, green: 0.25, blue: 0.85, alpha: 1)
        }
        if node.name == "buttonCyan"{
            run("sound-button")
            shapeNode.strokeColor = UIColor(red: 0.0, green: 1.0, blue: 0.8, alpha: 1)
        }
        if node.name == "buttonYellow"{
            run("sound-button")
            shapeNode.strokeColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1)
        }
        if node.name == "buttonEraser"{
            run("sound-button")
            if wayPoints.count == 0 { return }
            wayPoints.removeAll(keepingCapacity: true)
            //wayPoints.removeLast()
            /*if wayPoints.count >= 0 {
                wayPoints.removeFirst(wayPoints.count - 1)
            }
            wayPoints.removeLast()*/
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
                    currentTouchPosition = touch.location(in:self)
                }
            let node = self.atPoint(currentTouchPosition)
        if node.name == "drawArea"{
            wayPoints.append(currentTouchPosition)
            redrawPath()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func run(_ fileName: String){
               run(SKAction.playSoundFileNamed(fileName, waitForCompletion: true))
       }
    
    override func update(_ currentTime: TimeInterval) {
        let defaults = UserDefaults.standard
        defaults.set(playerFusil, forKey: scoreFusil)
        //defaults.set(wayPoints, forKey: scoreDraw)
    }
    
    private func redrawPath() {
      let path = UIBezierPath()
      path.move(to: wayPoints[0])

      for i in 1 ..< wayPoints.count {
        path.addLine(to: wayPoints[i])
      }

      shapeNode.path = path.cgPath
    }
    
    private func createPath() {
        shapeNode = SKShapeNode()
        shapeNode.zPosition = 4
        //shapeNode.strokeColor = UIColor(red: 0.3, green: 0.3, blue: 0.9, alpha: 1)
        shapeNode.lineWidth = 6
        //shapeNode.lineCap = (CGLineCap: round)

        addChild(shapeNode)
    }
 
    
}
