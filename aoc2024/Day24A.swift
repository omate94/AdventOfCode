import Foundation

class Day24A {
    struct Connection: Equatable{
        let wire1: String
        let wire2: String
        let gate: Gates
        let output: String
    }
    
    enum Gates: String {
        case or = "OR"
        case and = "AND"
        case xor = "XOR"
    }
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        let initials = input.intials
        var connections = input.connections
        
        var wires = [String: Int]()
        
        for initial in initials {
            wires[initial.0] = initial.1
        }
        
        while !connections.isEmpty {
            var tmp: [Connection] = []
            for i in 0..<connections.count {
                let connection = connections[i]
                if let wire1Val = wires[connection.wire1],
                   let wire2Val = wires[connection.wire2] {
                    switch connection.gate {
                    case .or:
                        wires[connection.output] = wire1Val | wire2Val
                    case .and:
                        wires[connection.output] = wire1Val & wire2Val
                    case .xor:
                        wires[connection.output] = wire1Val ^ wire2Val
                    }
                    tmp.append(connection)
                }
            }

            tmp.forEach { connection in
                connections.removeAll { $0 == connection }
            }
        }
        
        var binaryString = ""
        
        let keys = wires.keys.filter { $0.hasPrefix("z") }.sorted().reversed()
        for key in keys {
            binaryString.append(String(wires[key]!))
        }
        
        let result = Int(binaryString, radix: 2)!
        return String(result)
    }
    
    private func parse(path: String) -> (intials: [(String,Int)], connections: [Connection]) {
        let fileURL = URL(fileURLWithPath: path)
        let input = try! String(contentsOf: fileURL, encoding: .utf8)
            .split(separator: "\n")
            .map {
                $0.split(separator: " ").map { String($0) }
            }
        
        let initials = input.filter { $0.count == 2 }.map {
            return (String($0[0].dropLast()), Int($0[1])!)
        }
        
        let connections = input.filter { $0.count != 2 }.map {
            Connection(wire1: $0[0], wire2: $0[2], gate: Gates(rawValue: $0[1])!, output: $0[4])
        }
        
        return (initials, connections)
    }
}

extension Day24A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "24_test.txt")
        } else {
            return run(path: testPath + "24.txt")
        }
    }
}

