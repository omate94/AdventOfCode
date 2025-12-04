import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';

export class Day4A {
    private run(filePath: string): string {
        const map = this.parse(filePath);
        let result = 0;

        map.forEach((row, x) => {
            row.forEach((cell, y) => {
                if (cell === '@') {
                    const canLift = this.checkNeighbors(map, x, y);
                    if (canLift) {
                        result += 1;
                    }
                }
            });
        });

        return String(result);
    }

    private checkNeighbors(map: string[][], x: number, y: number): boolean {
        const neighbors = [
            [x - 1, y - 1], [x - 1, y], [x - 1, y + 1],
            [x, y - 1], [x, y + 1],
            [x + 1, y - 1], [x + 1, y], [x + 1, y + 1]
        ];

        
        let count = 0;
        for (const [nx, ny] of neighbors) {
            if (nx >= 0 && nx < map.length && ny >= 0 && ny < map[0].length) {
                if (map[nx][ny] === '@') {
                    count++;
                }
            }
        }

        return count < 4;
    }
    
    private parse(filePath: string): string[][] {
        return readInputLinesFromPath(filePath)
            .map(line => 
                line.split('')
            );
    }

    execute(test: boolean): string {
        const testPath = path.join(__dirname, '../../tests/2025/');
        if (test) {
            return this.run(path.join(testPath, '4_test.txt'));
        } else {
            return this.run(path.join(testPath, '4.txt'));
        }
    }
}