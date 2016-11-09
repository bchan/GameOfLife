//
//  Colony.swift
//  GameOfLife
//
//  Created by Benjamin Chan on 11/9/16.
//  Copyright © 2016 Benjamin Chan. All rights reserved.
//

import Foundation

class Colony: CustomStringConvertible {
    
    
    var aliveCells: Set<Cell> = Set()
    var potentialCells: Set<Cell> = Set()
    var colonySize = 20
    var generationNumber = 0
    
    var description: String {
        var printOut = ""
        print("Generation # \(generationNumber)")
        for y in 0...20 {
            for x in 0...20 {
                if isCellAlive(x, yCoor: 20 - y) {
                    printOut += "* "
                } else {
                    printOut += " "
                }
            }
            printOut += "\n"
        }
        return printOut
    }
    
    func setCellAlive(xCoor: Int, yCoor: Int) {
        aliveCells.insert(Cell(xCoor: xCoor, yCoor: yCoor))
    }
    
    func setCellDead(xCoor: Int, yCoor: Int) {
        let deadCell = Cell(xCoor: xCoor, yCoor: yCoor)
        if aliveCells.contains(deadCell) {
            aliveCells.remove(deadCell)
        }
    }
    
    func resetColony() {
        aliveCells.removeAll()
        generationNumber = 0
    }
    
    func isCellAlive(xCoor: Int, yCoor: Int) -> Bool {
        let checkCell = Cell(xCoor: xCoor, yCoor: yCoor)
        if aliveCells.contains(checkCell) {
            return true
        } else {
            return false
        }
    }
    
    func convertAlive(xCoor: Int, yCoor: Int) -> Int {
        if isCellAlive(xCoor, yCoor: yCoor) {
            return 1
        } else {
            return 0
        }
    }
    
    func countLivingNeighbors(xCoor: Int, yCoor: Int) -> Int {
        var count = 0
        count += convertAlive(xCoor - 1, yCoor: yCoor + 1) + convertAlive(xCoor, yCoor: yCoor + 1) + convertAlive(xCoor + 1, yCoor: yCoor + 1)
        count += convertAlive(xCoor - 1, yCoor: yCoor) + convertAlive(xCoor + 1, yCoor: yCoor)
        count += convertAlive(xCoor - 1, yCoor: yCoor - 1) + convertAlive(xCoor, yCoor: yCoor - 1) + convertAlive(xCoor + 1, yCoor: yCoor - 1)
        
        return count
    }
    
    func makePotentialCells() -> Set<Cell> {
        var potentialCells = Set<Cell>()
        
        for i in aliveCells {
            let xCoor = i.xCoor
            let yCoor = i.yCoor
            
            potentialCells.insert(Cell(xCoor: xCoor - 1, yCoor: yCoor - 1))
            potentialCells.insert(Cell(xCoor: xCoor - 1, yCoor: yCoor))
            potentialCells.insert(Cell(xCoor: xCoor - 1, yCoor: yCoor + 1))
            potentialCells.insert(Cell(xCoor: xCoor - 1, yCoor: yCoor))
            potentialCells.insert(Cell(xCoor: xCoor, yCoor: yCoor))
            potentialCells.insert(Cell(xCoor: xCoor + 1, yCoor: yCoor))
            potentialCells.insert(Cell(xCoor: xCoor - 1, yCoor: yCoor + 1))
            potentialCells.insert(Cell(xCoor: xCoor, yCoor: yCoor + 1))
            potentialCells.insert(Cell(xCoor: xCoor + 1, yCoor: yCoor + 1))
        }
        return potentialCells
    }
    
    func checkPotentialCell(potentialCell: Cell) -> Bool {
        let xCoor = potentialCell.xCoor
        let yCoor = potentialCell.yCoor
        
        if aliveCells.contains(potentialCell) {
            if countLivingNeighbors(xCoor, yCoor: yCoor) == 2 || countLivingNeighbors(xCoor, yCoor: yCoor) == 3 {
                return true
            }
        } else {
            if countLivingNeighbors(xCoor, yCoor: yCoor) == 3 {
                return true
            }
        }
        return false
    }
    
    
    func evolve() {
        var addCells: Set<Cell> = Set()
        let potentialCells: Set<Cell> = makePotentialCells()
        
        for i in potentialCells {
            if checkPotentialCell(i) {
                addCells.insert(i)
            }
        }
        aliveCells = addCells
        generationNumber += 1
    }
    
}







