//
//  GameManager.swift
//  Snake
//
//  Created by Німець Іван Олександрович on 25.01.2020.
//  Copyright © 2020 Німець Іван Олександрович. All rights reserved.
//

import SpriteKit
class GameManager {
    var nextTime: Double?
    var timeExtension: Double = 0.5
    var scene: GameScene!
    
    enum snakeDirections {
        case up, right, down, left
    }
    
    var playerDirection = snakeDirections.down
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    func initGame() {
        scene.playerPositions.append((10, 10))
        scene.playerPositions.append((10, 11))
        scene.playerPositions.append((10, 12))
        renderChange()
    }
    
    func renderChange() {
        for (node, x, y) in scene.gameArray {
            if Utils.contais(array: scene.playerPositions, point: (x, y)) {
                node.fillColor = SKColor.white
            } else {
                node.fillColor = SKColor.clear
            }
        }
        
    }
    
    func update(time: Double){
        if nextTime == nil {
            nextTime = time + timeExtension
        } else {
            if time >= nextTime! {
                nextTime = time + timeExtension
                updatePlayerPosition()
            }
        }
    }
    
    private func updatePlayerPosition() {
        var xChange = -1
        var yChange = 0
        switch playerDirection {
        case .up:
            xChange = 0
            yChange = -1
            break
        case .right:
            xChange = 1
            yChange = 0
            break
        case .down:
            xChange = 0
            yChange = 1
            break
        case .left:
            xChange = -1
            yChange = 0
            break
            
        }
        
        if scene.playerPositions.count > 0 {
            
            var start = scene.playerPositions.count - 1
            while start > 0 {
                scene.playerPositions[start] = scene.playerPositions[start - 1]
                start -= 1
            }
            scene.playerPositions[0] = (scene.playerPositions[0].0 + yChange, scene.playerPositions[0].1 + xChange)
            let (y, x) = scene.playerPositions[0]
            if y > scene.boardHeight {
                scene.playerPositions[0].0 = 0
            } else if y < 0 {
                scene.playerPositions[0].0 = scene.boardHeight
            } else if x < 0 {
                scene.playerPositions[0].1 = scene.boardWidth
            } else if x >= scene.boardWidth {
                scene.playerPositions[0].1 = 0
            }
        }
        renderChange()
    }
    func swipe(id: snakeDirections) {
        if !(id == .up && playerDirection == .down) && !(id == .down && playerDirection == .up) {
            if !(id == .left && playerDirection == .right) && !(id == .right && playerDirection == .left) {
                playerDirection = id
            }
        }
    }
    
}
