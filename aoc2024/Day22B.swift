import Foundation

class Day22B {
    private var sequences: [[Int]: [Int]] = [:]
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        
        for num in input {
            var number = num
            var diffs = [Int]()
            var previous = Int(String(String(number).last!))!
            var localSequences: [[Int]: Int] = [:]
            for _ in 0..<2000 {
                number = prune(num: mix(a: number, b: number*64))
                number = prune(num: mix(a: number, b: number/32))
                number = prune(num: mix(a: number, b: number*2048))
                
                let lastDigit = Int(String(String(number).last!))!
                diffs.append(lastDigit-previous)
                previous = lastDigit

                if diffs.count == 4 {
                    if localSequences[diffs] == nil {
                        localSequences[diffs] = lastDigit
                    }
                    
                    diffs.removeFirst()
                }
            }
            mergeSequences(localSequences)
            localSequences = [:]
        }
        
        var res = 0
        for val in sequences.values {
            res = max(res, val.reduce(0, +))
        }
        return String(res)
    }
    
    private func mergeSequences(_ _sequences: [[Int]: Int]) {
        for key in _sequences.keys {
            var sequence = sequences[key] ?? []
            sequence.append(_sequences[key]!)
            sequences[key] = sequence
        }
    }
    
    private func mix(a: Int, b: Int) -> Int {
        return a ^ b
    }
    
    private func prune(num: Int) -> Int {
        return num % 16777216
    }
    
    private func parse(path: String) -> [Int] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8)
            .split(separator: "\n")
            .map {
                Int(String($0))!
            }
    }
}

extension Day22B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "22_test.txt")
        } else {
            return run(path: testPath + "22.txt")
        }
    }
}

