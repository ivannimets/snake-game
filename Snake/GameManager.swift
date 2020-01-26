//
//  GameManager.swift
//  Snake
//
//  Created by Німець Іван Олександрович on 25.01.2020.
//  Copyright © 2020 Німець Іван Олександрович. All rights reserved.
//

import SpriteKit
class GameManager {
    var scene: GameScene!
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
    
}
