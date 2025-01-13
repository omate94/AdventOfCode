import Foundation

class Day25A {
    private func run(path: String) -> String {
        let input = parse(path: path)
        
        let locksMap = input.filter {
            !$0.first!.contains(".")
        }
        
        let keysMap = input.filter {
            !$0.last!.contains(".")
        }
        
        var locks = [[Int]]()
        
        for lockMap in locksMap {
            var lock = [Int]()
            for i in 0..<lockMap[0].count {
                let col = lockMap.getColumn(column: i)
                let num = col.filter { $0 == "#" }.count
                lock.append(num - 1)
            }
            locks.append(lock)
        }
        
        var keys = [[Int]]()
        
        for keyMap in keysMap {
            var key = [Int]()
            for i in 0..<keyMap[0].count {
                let col = keyMap.getColumn(column: i)
                let num = col.filter { $0 == "#" }.count
                key.append(num - 1)
            }
            keys.append(key)
        }
        
        var count = 0
        for key in keys {
            for lock in locks {
                var isValid = true
                for i in 0..<key.count {
                    if key[i] + lock[i] > 5 {
                        isValid = false
                        break
                    }
                }
                if isValid {
                    count += 1
                }
                isValid = true
            }
        }

        return String(count)
    }
    
    private func parse(path: String) -> [[[String]]] {
        let fileURL = URL(fileURLWithPath: path)
        let input = try! String(contentsOf: fileURL, encoding: .utf8)
            .split(separator: "\n\n")
            .map { String($0).split(separator: "\n").map { Array(String($0)).map { String($0) } } }

        return input
    }
}

extension Day25A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "25_test.txt")
        } else {
            return run(path: testPath + "25.txt")
        }
    }
}

