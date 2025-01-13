import Foundation

class Day19B {
    private func run(path: String) -> String {
        let input = parse(path: path)
        let patterns = input.first!
        let designs = input.last!
        
        let count = designs
            .map { checkDesign($0, patterns: patterns) }
            .reduce(0, +)
        
        return String(count)
    }
    
    private var cache = [String: Int]()
    private func checkDesign(_ design: String, patterns: [String]) -> Int {
        if design.isEmpty {
            return 1
        }

        if let cachedResult = cache[design] {
            return cachedResult
        }

        var ways = 0
        for pattern in patterns {
            if design.hasPrefix(pattern) {
                let leftover = String(design.dropFirst(pattern.count))
                ways += checkDesign(leftover, patterns: patterns)
            }
        }

        cache[design] = ways
        return ways
    }
    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        let input = try! String(contentsOf: fileURL, encoding: .utf8)
            .split(separator: "\n\n")
        
        let towels = input[0].split(separator: ", ").map { String($0) }
        let designs = input[1].split(separator: "\n").map { String($0) }
        
        return [towels, designs]
    }
}

extension Day19B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "19_test.txt")
        } else {
            return run(path: testPath + "19.txt")
        }
    }
}

