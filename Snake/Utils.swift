//
//  Utils.swift
//  Snake
//
//  Created by Німець Іван Олександрович on 27.01.2020.
//  Copyright © 2020 Німець Іван Олександрович. All rights reserved.
//

class Utils {
    static func contais(array: [(Int, Int)], point: (Int, Int)) -> Bool {
        let (x, y) = point
        for (ax, ay) in array {
            if (ax == x && ay == y) {
                return true
            }
        }
        return false
    }
}
