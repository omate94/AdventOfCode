import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';

export class Day7B {
    private memo: Map<string, number> = new Map();

    private run(filePath: string): string {
        let map = this.parse(filePath);
        let start = map[0].indexOf('S');
        map[0][start] = '.';
        this.memo.clear();
        let totalPaths = this.countPaths(map, 0, start);

        return String(totalPaths);
    }

    private countPaths(map: string[][], i: number, j: number): number {
        if (i >= map.length) {
            return 1;
        }

        const key = `${i},${j}`;
        if (this.memo.has(key)) {
            return this.memo.get(key)!;
        }

        let result: number;
        if (map[i][j] === '.') {
            result = this.countPaths(map, i+1, j);
        } else if (map[i][j] === '^') {
            result = this.countPaths(map, i+1, j-1) + this.countPaths(map, i+1, j+1);
        } else {
            result = 0;
        }

        this.memo.set(key, result);
        return result;
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
            return this.run(path.join(testPath, '7_test.txt'));
        } else {
            return this.run(path.join(testPath, '7.txt'));
        }
    }
}