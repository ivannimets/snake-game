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
    
    override func didMove(to view: SKView) {
        initializeMenu()
    }
    
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    private func initializeMenu(){
        
        
        gamelogo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        gamelogo.zPosition = 1
        gamelogo.position = CGPoint(x: 0, y: (frame.size.height / 2)-200 )
        gamelogo.fontSize = 60
        gamelogo.text = "snake"
        gamelogo.fontColor = SKColor.red
        self.addChild(gamelogo)
    }
}
