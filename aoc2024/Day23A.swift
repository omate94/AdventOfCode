import Foundation

class Day23A {    
    private func run(path: String) -> String {
        let input = parse(path: path)
        
        var connections = [String: Set<String>]()
        var threeConnections: Set<Set<String>> = []
        
        for pair in input {
            var connectedA = connections[pair.compA] ?? []
            connectedA.insert(pair.compB)
            connections[pair.compA] = connectedA
            
            var connectedB = connections[pair.compB] ?? []
            connectedB.insert(pair.compA)
            connections[pair.compB] = connectedB
        }
        
        for key in connections.keys {
            let connectedComputers = connections[key]!
            for connectedComputer in connectedComputers {
                let asda = connections[connectedComputer]!
                for asd in asda {
                    if asd != key {
                        if connectedComputers.contains(asd) {
                            threeConnections.insert([key, connectedComputer, asd])
                        }
                    }
                }
            }
        }
        
        
        var count = 0
        
        for cons in threeConnections {
            for con in cons {
                if con.hasPrefix("t") {
                    count += 1
                    break
                }
            }
        }
        
        return String(count)
    }
    
    
    private func parse(path: String) -> [(compA: String, compB: String)] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8)
            .split(separator: "\n")
            .map {
                $0.split(separator: "-")
            }.map {
              (String($0.first!), String($0.last!))
            }
    }
}

extension Day23A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "23_test.txt")
        } else {
            return run(path: testPath + "23.txt")
        }
    }
}

