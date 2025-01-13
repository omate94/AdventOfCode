import Foundation

class Day16B {
    private struct Position: Hashable {
        let x: Int
        let y: Int
    }
    
    private struct Deer: Hashable {
        let position: Position
        let direction: Direction
    }
    
    private enum Direction: Hashable {
        case north, east, south, west
    }
    
    private struct Route {
        let deer: Deer
        let path: [Deer]
        let cost: Int
    }

    private func run(path: String) -> String {
        let input = parse(path: path)
        
        var startPosition: Position!
        var endPosition: Position!
        
        for i in 0..<input.count {
            for j in 0..<input[i].count {
                if input[i][j] == "S" {
                    startPosition = Position(x: j, y: i)
                } else if input[i][j] == "E" {
                    endPosition = Position(x: j, y: i)
                }
            }
        }
        
        var queue: [Route] = [Route(deer: Deer(position: startPosition, direction: .east), path: [], cost: 0)]
        var prices: [Deer: Int] = [Deer(position: startPosition, direction: .east): 0]
        var routesToEnd: [Route] = []
        
        while !queue.isEmpty {
            var nextQueue: [Route] = []
            for currentRoute in queue {
                let currentDeer = currentRoute.deer
                let currentCost = currentRoute.cost
                let currentPath = currentRoute.path
                
                let possibleSteps = makeStep(from: currentDeer.position, map: input)
                
                for (newPosition, newDirection) in possibleSteps {
                    let directionChangeCost = (newDirection == currentDeer.direction) ? 0 : 1000
                    let newCost = currentCost + 1 + directionChangeCost
                    
                    let newDeer = Deer(position: newPosition, direction: newDirection)
                    
                    if let existingCost = prices[newDeer], existingCost < newCost {
                        continue
                    }
                    
                    prices[newDeer] = newCost
                    let newPath = currentPath + [currentDeer]
                    let newRoute = Route(deer: newDeer, path: newPath, cost: newCost)
                    nextQueue.append(newRoute)
                    
                    if newDeer.position == endPosition {
                        routesToEnd.append(newRoute)
                    }
                }
            }
            queue = nextQueue
        }
        
        let validRoutes = routesToEnd.filter { $0.cost == routesToEnd.min(by: { $0.cost < $1.cost })?.cost }
        
        var tilesVisited: Set<Position> = []
        
        for route in validRoutes {
            route.path.forEach {
                tilesVisited.insert($0.position)
            }
        }
        return String(tilesVisited.count)
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
    
    private func makeStep(from position: Position, map: [[String]]) -> [(Position, Direction)] {
        var nextSteps: [(Position, Direction)] = []
        
        if map[position.y][position.x] == "E" {
            return []
        }
        
        if position.x == 0 && position.y == 0 {
            if map[position.y+1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y+1), .south))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.append((Position(x: position.x+1, y: position.y), .east))
            }
        } else if position.x == 0 && position.y == map.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y-1), .north))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.append((Position(x: position.x+1, y: position.y), .east))
            }
        } else if position.x == map.first!.count - 1 && position.y == 0 {
            if map[position.y+1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y+1), .south))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.append((Position(x: position.x-1, y: position.y), .west))
            }
            return nextSteps
        } else if position.x == map.first!.count - 1 && position.y == map.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y-1), .north))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.append((Position(x: position.x-1, y: position.y), .west))
            }
        } else if position.x == 0 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y-1), .north))
            }
            
            if map[position.y+1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y+1), .south))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.append((Position(x: position.x+1, y: position.y), .east))
            }
        } else if position.y == 0 {
            if map[position.y+1][position.x]  != "#" {
                nextSteps.append((Position(x: position.x, y: position.y+1), .south))
            }
            
            if map[position.y][position.x-1]  != "#" {
                nextSteps.append((Position(x: position.x-1, y: position.y), .west))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.append((Position(x: position.x+1, y: position.y), .east))
            }
        } else if position.x == map.first!.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y-1), .north))
            }
            
            if map[position.y+1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y+1), .south))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.append((Position(x: position.x-1, y: position.y), .west))
            }
        } else if position.y == map.count - 1 {
            if map[position.y-1][position.x]  != "#" {
                nextSteps.append((Position(x: position.x, y: position.y-1), .north))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.append((Position(x: position.x-1, y: position.y), .west))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.append((Position(x: position.x+1, y: position.y), .east))
            }
        } else {
            if map[position.y-1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y-1), .north))
            }
            
            if map[position.y+1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y+1), .south))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.append((Position(x: position.x+1, y: position.y), .east))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.append((Position(x: position.x-1, y: position.y), .west))
            }
        }
        
        return nextSteps
    }
}

extension Day16B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "16_test_2.txt")
        } else {
            return run(path: testPath + "16.txt")
        }
    }
}

