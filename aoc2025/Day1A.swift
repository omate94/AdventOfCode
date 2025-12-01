import Foundation

fileprivate enum Direction {
    case left, right
}

class Day1A {
    private func run(path: String) -> String {
        let actions = parse(path: path)
        
        var start = 50
        var count = 0
        
        for action in actions {
            let clicks = action.clicks % 100
            switch action.direction {
            case .left:
                start = start - clicks
            case .right:
                start = start + clicks
            }
            
            if start < 0 {
                start = 100 - abs(start)
            } else if start > 99 {
                start = 0 + start - 100
            }
            
            if start == 0 {
                count += 1
            }
            print(start)
        }
        
        return String(count)
    }
    
    private func parse(path: String) -> [(direction: Direction, clicks: Int)] {
        let fileURL = URL(fileURLWithPath: path)
        let res = try! String(contentsOf: fileURL, encoding: .utf8).split(separator: "\n")
            .map {
                let dir = $0.first == "L" ? Direction.left : Direction.right
                let num = Int($0.dropFirst())!
                return (direction: dir, clicks: num)
            }

        return res
    }
}

extension Day1A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "1_test.txt")
        } else {
            return run(path: testPath + "1.txt")
        }
    }
}
