import Foundation

class Day22A {
    private func run(path: String) -> String {
        let input = parse(path: path)
        
        var secrets = [Int]()

        for num in input {
            var number = num
            for _ in 0..<2000 {
                number = prune(num: mix(a: number, b: number*64))
                number = prune(num: mix(a: number, b: number/32))
                number = prune(num: mix(a: number, b: number*2048))
            }
            secrets.append(number)
        }
        
        return String(secrets.reduce(0, +))
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

extension Day22A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "22_test.txt")
        } else {
            return run(path: testPath + "22.txt")
        }
    }
}

