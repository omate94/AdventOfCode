import Foundation

class Day23B {
    private func run(path: String) -> String {
        let input = parse(path: path)
        var connectionsDict = [String: Set<String>]()
        
        for pair in input {
            var connectedA = connectionsDict[pair.compA] ?? []
            connectedA.insert(pair.compB)
            connectedA.insert(pair.compA)
            connectionsDict[pair.compA] = connectedA
            
            var connectedB = connectionsDict[pair.compB] ?? []
            connectedB.insert(pair.compA)
            connectedB.insert(pair.compB)
            connectionsDict[pair.compB] = connectedB
        }

        var longestConnection: Set<String> = []
        
        for key in connectionsDict.keys {
            var validConnection: Set<String> = connectionsDict[key]!
            let connections = connectionsDict[key]!
            
            for connection in connections {
                if validConnection.contains(connection) {
                    validConnection.formIntersection(connectionsDict[connection]!)
                }
            }

            if validConnection.count > longestConnection.count {
                longestConnection = validConnection
            }
        }
        
        let result = Array(longestConnection).sorted().joined(separator: ",")
        return result
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

extension Day23B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "23_test.txt")
        } else {
            return run(path: testPath + "23.txt")
        }
    }
}

