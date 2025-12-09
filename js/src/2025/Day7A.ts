import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';

export class Day7A {
    private run(filePath: string): string {
        let map = this.parse(filePath);
        let result = 0;
        let start = map[0].indexOf('S');
        map[0][start] = '|';

        for (let i = 0; i < map.length - 1; i++) {
            for (let j = 0; j < map[i].length; j++) {
                if (map[i][j] === '|') {
                    if (map[i+1][j] === '.') {
                        map[i+1][j] = '|';
                    } else if (map[i+1][j] === '^') {
                        result += 1;
                        map[i+1][j-1] = '|';
                        map[i+1][j+1] = '|';
                    }
                }
            }
        }

        return String(result);
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