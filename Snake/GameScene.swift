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
    
    var currentScore: SKLabelNode!
    var playerPositions: [(Int, Int)]=[]
    var gameBackground: SKShapeNode!
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    
    var game: GameManager!
    
    override func didMove(to view: SKView) {
        initializeMenu()
        game = GameManager()
        initializeGameView()
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

//    starts game,is called start button clicked
    private func startGame() {
        print("start game!!!")
        gamelogo.run(SKAction.move(by: CGVector(dx:-50, dy: 600), duration: 0.5)) {
            self.gamelogo.isHidden = true
        }
        playButton.run(SKAction.scale(to: 0, duration: 0.2)) {
            self.playButton.isHidden = true
        }
        let bottomCenter = CGPoint(x: 0, y: (frame.size.height / -2)+20)
        bestScore.run(SKAction.move(to: bottomCenter,duration:0.5)) {
            self.gameBackground.setScale(0)
            self.currentScore.setScale(0)
            self.gameBackground.isHidden = false
            self.currentScore.isHidden = false
            self.gameBackground.run(SKAction.scale(to: 1, duration: 0.4))
            self.currentScore.run(SKAction.scale(to: 1, duration: 0.4))
        }
    }
    private func initializeGameView() {
        currentScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x: 0, y: (frame.size.height / -2) + 60)
        currentScore.fontSize = 40
        currentScore.isHidden = true
        currentScore.text = "Score: 0"
        currentScore.fontColor = SKColor.white
        self.addChild(currentScore)
        
        let numCols = 20
        let aproximateWidth = frame.size.width - 100
        let cellWidth = aproximateWidth / CGFloat(numCols)
        let width = Int(cellWidth * CGFloat(numCols))
        let aproximateHeight = frame.size.height - 200
        let numRows = Int(aproximateHeight / cellWidth)
        let height = Int(CGFloat(numRows) * cellWidth)
        let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
        gameBackground = SKShapeNode(rect: rect, cornerRadius: 0.02)
        gameBackground.fillColor = SKColor.darkGray
        gameBackground.zPosition = 2
        gameBackground.isHidden = true
        self.addChild(gameBackground)
        
        createGameBoard(width: width, height: height, cellWidth: cellWidth, numRows: numRows, numCols: numCols)
    }
    
//    creates cells board
    private func createGameBoard(width: Int, height: Int, cellWidth: CGFloat, numRows: Int, numCols: Int) {
        var x = CGFloat(width / -2) + (cellWidth / 2)
        var y = CGFloat(height / 2) - (cellWidth / 2)
        for row in 0...numRows - 1 {
            for col in 0...numCols - 1 {
                let cellNode = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellWidth))
                cellNode.strokeColor = SKColor.black
                cellNode.zPosition = 2
                cellNode.position = CGPoint(x: x, y: y)
                
                gameArray.append((node: cellNode, x:row,y: col))
                gameBackground.addChild(cellNode)
                
                x += cellWidth
            }
            x = CGFloat(width / -2) + (cellWidth / 2)
            y -= cellWidth
        }
    }
    
    
    
}
