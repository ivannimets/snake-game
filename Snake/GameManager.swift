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
    var timeExtension: Double = 0.2
    var scene: GameScene!
    var currentScore: Int = 0
    
    
    enum snakeDirections {
        case up, right, down, left, dead
    }
    
    var playerDirection = snakeDirections.down
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    func initGame() {
        scene.playerPositions.append((10, 10))
        scene.playerPositions.append((10, 11))
        scene.playerPositions.append((10, 12))
        generateNewPoint()
        renderChange()
    }
    
    func renderChange() {
        for (node, x, y) in scene.gameArray {
            if Utils.contais(array: scene.playerPositions, point: (x, y)) {
                node.fillColor = SKColor.white
            } else {
                node.fillColor = SKColor.clear
            }
            if scene.scorePos != nil {
                if Int((scene.scorePos?.x)!) == y &&       Int((scene.scorePos?.y)!) == x {
                    node.fillColor = SKColor.red
                }
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
                checkForScore()
                checkForDeath()
                finishAnimation()
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
        case .dead:
            xChange = 0
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
    
    private func generateNewPoint() {
        var randomX = CGFloat(arc4random_uniform(UInt32(scene.boardWidth!)))
        var randomY = CGFloat(arc4random_uniform(UInt32(scene.boardHeight!)))
        while Utils.contais(array: scene.playerPositions, point: (Int(randomX), Int(randomY))) {
            randomX = CGFloat(arc4random_uniform(UInt32(scene.boardWidth!)))
            randomY = CGFloat(arc4random_uniform(UInt32(scene.boardHeight!)))
        }
        scene.scorePos = CGPoint(x: randomX, y: randomY)
    }
    
    private func checkForScore() {
        if scene.scorePos != nil {
            let (x, y) = scene.playerPositions[0]
            if Int((scene.scorePos?.x)!) == y && Int((scene.scorePos?.y)!) == x {
                currentScore += 1
                scene.currentScore.text = "Score: \(currentScore)"
                generateNewPoint()
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
            }
        }
    }
    
    private func checkForDeath() {
        if scene.playerPositions.count > 0 {
            var arrayOfPositions = scene.playerPositions
            let headOfSnake = arrayOfPositions[0]
            arrayOfPositions.remove(at: 0)
            if Utils.contais(array: arrayOfPositions, point: headOfSnake) {
                playerDirection = .dead
                
            }
        }
    }
    
    private func finishAnimation() {
        if playerDirection == .dead && scene.playerPositions.count > 0 {
            var hasFinished = true
            let headOfSnake = scene.playerPositions[0]
            for position in scene.playerPositions {
                if headOfSnake != position {
                    hasFinished = false
                }
            }
            
            if hasFinished {
                print("end game")
                playerDirection = .up
                scene.scorePos = nil
                scene.playerPositions.removeAll()
                renderChange()
                scene.currentScore.run(SKAction.scale(to: 0, duration: 0.4)) {
                    self.scene.currentScore.isHidden = true
                }
                scene.gameBackground.run(SKAction.scale(to: 0, duration: 0.4)) {
                    self.scene.gameBackground.isHidden = true
                    self.scene.gamelogo.isHidden = false
                    self.scene.gamelogo.run(SKAction.move(to: CGPoint(x: 0, y: (self.scene.frame.size.height / 2) - 200), duration: 0.5)) {
                        self.scene.playButton.isHidden = false
                        self.scene.playButton.run(SKAction.scale(to: 1, duration: 0.3))
                        self.scene.bestScore.run(SKAction.move(to: CGPoint(x: 0, y: self.scene.gamelogo.position.y - 50), duration: 0.3))
                    }
                }
            }
        }
    }
}
