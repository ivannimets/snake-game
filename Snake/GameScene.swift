//
//  GameScene.swift
//  Snake
//
//  Created by Німець Іван Олександрович on 25.01.2020.
//  Copyright © 2020 Німець Іван Олександрович. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //обявляем контент строки
    var gamelogo: SKLabelNode!
    var bestScore: SKLabelNode!
    var playButton:SKShapeNode!
    
    var game: GameManager!
    
    override func didMove(to view: SKView) {
        initializeMenu()
        game = GameManager()
    }
    
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes {
                if node.name == "play_button" {
                    startGame()
                }
            }
        }
            
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    private func initializeMenu(){
        
        
        gamelogo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        gamelogo.zPosition = 1
        gamelogo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 200)
        gamelogo.fontSize = 60
        gamelogo.text = "snake"
        gamelogo.fontColor = SKColor.red
        self.addChild(gamelogo)
        
        bestScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: gamelogo.position.y - 50)
        bestScore.fontSize = 40
        bestScore.text = "Best Score : 0"
        bestScore.fontColor = SKColor.white
        self.addChild(bestScore)
        
        playButton = SKShapeNode()
        playButton.name = "play_button"
        playButton.zPosition = 1
        playButton.position = CGPoint(x: 0, y: (frame.size.height / -2) + 600)
        playButton.fillColor = SKColor.white
        let topCorner = CGPoint(x: -100, y: 200)
        let bottomCorner = CGPoint(x: -100, y: 0)
        let middle = CGPoint(x: 100, y: 100)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        playButton.path = path
        self.addChild(playButton)
    }
    private func startGame() {
        print("start game!!!")
    }
}
