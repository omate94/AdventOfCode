import Foundation

class Day20B {
    
    struct Position: Hashable {
        let x: Int
        let y: Int
    }
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        
        var startPosition: Position!
        for i in 0..<input.count {
            for j in 0..<input[i].count {
                if input[i][j] == "S" {
                    startPosition = Position(x: j, y: i)
                }
            }
        }
        
        var endPosition: Position!
        for i in 0..<input.count {
            for j in 0..<input[i].count {
                if input[i][j] == "E" {
                    endPosition = Position(x: j, y: i)
                }
            }
        }
        
        let trackTiles = runTrack(map: input, startPos: startPosition, endPos: endPosition)
                
        var result = 0
        for tile in trackTiles {
            var cheats: Set<Position> = []
            let possibleCheats = findCheats(from: tile.key, mapSize: input.count)
            for possibleCheat in possibleCheats {
                if let original = trackTiles[possibleCheat.0],
                      !cheats.contains(possibleCheat.0),
                      original >= tile.value + possibleCheat.1 + 100  {
                    cheats.insert(possibleCheat.0)
                }
            }
            result += cheats.count
        }
        
        return String(result)
    }
    
    private func findCheats(from position: Position, mapSize: Int) -> [(Position, Int)] {
        var cheats: [(Position, Int)] = []
        for x in -20...20 {
          for y in -20...20 {
            guard abs(x) + abs(y) <= 20 else { continue }
              let cheatPos = Position(x: position.x + x, y: position.y + y)
              if cheatPos.x > 0 && cheatPos.y > 0 && cheatPos.x < mapSize && cheatPos.y < mapSize {
                  cheats.append((cheatPos, abs(x) + abs(y)))
              }
          }
        }
        return cheats
    }
    
    private func runTrack(map: [[String]], startPos: Position, endPos: Position) -> [Position: Int] {
        var currentSteps: [Position] = [startPos]
        var prices: [Position: Int] = [startPos: 0]
        
        while !currentSteps.isEmpty {
            var nextSteps: [Position] = []
            for currentStep in currentSteps {
                let newSteps = makeStep(from: currentStep, map: map)
                var validSteps: [Position] = []
                for newStep in newSteps {
                    let currentPrice = prices[currentStep]!
                    if let newStepPrice = prices[newStep] {
                        if newStepPrice > currentPrice + 1 {
                            validSteps.append(newStep)
                            prices[newStep] = currentPrice + 1
                        }
                    } else {
                        validSteps.append(newStep)
                        prices[newStep] = currentPrice + 1
                    }
                }
                nextSteps.append(contentsOf: validSteps)
            }
            currentSteps = nextSteps
        }
        
        return prices
    }
    
    private func makeStep(from position: Position, map: [[String]]) -> Set<Position> {
        var nextSteps: Set<Position> = []
        if position.x == 0 && position.y == 0 {
            if map[position.y+1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.x == 0 && position.y == map.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.x == map.first!.count - 1 && position.y == 0 {
            if map[position.y+1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
            return nextSteps
        } else if position.x == map.first!.count - 1 && position.y == map.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
        } else if position.x == 0 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y+1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.y == 0 {
            if map[position.y+1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.x == map.first!.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y+1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
        } else if position.y == map.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else {
            if map[position.y-1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y+1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
        }
        
        return nextSteps
    }

    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8)
            .split(separator: "\n")
            .map {
                return Array($0)
                    .map { String($0) }
            }
    }
}

extension Day20B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "20_test.txt")
        } else {
            return run(path: testPath + "20.txt")
        }
    }
}

