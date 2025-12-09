import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';

interface Range {
    start: number;
    end: number;
}

export class Day5A {
    private run(filePath: string): string {
        const { ranges, numbers } = this.parse(filePath);
        let result = 0;

        for (const number of numbers) {
            for (const range of ranges) {
                if (number >= range.start && number <= range.end) {
                    result += 1;
                    break;
                }
            }
        }

        return String(result);
    }

    
    private parse(filePath: string): { ranges: Range[], numbers: number[] } {
        const lines = readInputLinesFromPath(filePath);
        const separatorIndex = lines.findIndex(line => line.trim() === '');
        
        const ranges: Range[] = lines
            .slice(0, separatorIndex)
            .map(line => {
                const [start, end] = line.split('-').map(Number);
                return { start, end };
            });
        
        const numbers: number[] = lines
            .slice(separatorIndex + 1)
            .map(Number);
        
        return { ranges, numbers };
    }

    execute(test: boolean): string {
        const testPath = path.join(__dirname, '../../tests/2025/');
        if (test) {
            return this.run(path.join(testPath, '5_test.txt'));
        } else {
            return this.run(path.join(testPath, '5.txt'));
        }
    }
}