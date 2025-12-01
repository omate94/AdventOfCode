import Foundation

fileprivate enum Direction {
    case left, right
}

class Day1B {
    
    private func run(path: String) -> String {
        let actions = parse(path: path)
        
        var start = 50
        var count = 0
        
        for action in actions {
            let zeros = action.clicks / 100
            let clicks = action.clicks % 100
            count += zeros
            print("Start:", start, "Clicks:", clicks, "Zeros:", zeros, "Count:", count)
            
            switch action.direction {
            case .left:
                start = start - clicks
            case .right:
                start = start + clicks
            }
            print("new Start:", start)
            if start == 0 {
                count += 1
            } else if start < 0  {
                if start + clicks != 0 {
                    count += 1
                }
                start = 100 - abs(start)
            } else if start > 99 {
                start = 0 + start - 100
                count += 1
            }
            print("fixed Start:", start, "new Count:", count)
            print("    ")
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

extension Day1B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "1_test.txt")
        } else {
            return run(path: testPath + "1.txt")
        }
    }
}
