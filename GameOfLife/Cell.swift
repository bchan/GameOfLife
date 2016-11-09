//
//  Cell.swift
//  GameOfLife
//
//  Created by Benjamin Chan on 11/9/16.
//  Copyright © 2016 Benjamin Chan. All rights reserved.
//

import Foundation

struct Cell: Hashable, CustomStringConvertible {
    
    var hashValue: Int {
        return xCoor * xCoor * xCoor * xCoor * xCoor * xCoor * xCoor * xCoor * yCoor
    }
    
    var description: String {
        return "\(xCoor) \(yCoor) \(hashValue)"
    }
    
    let xCoor: Int
    let yCoor: Int
    
    init(xCoor: Int, yCoor: Int) {
        self.xCoor = xCoor
        self.yCoor = yCoor
    }
    
    
}

