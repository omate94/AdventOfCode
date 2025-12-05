import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';

interface Range {
    start: number;
    end: number;
}


export class Day5B {
    private run(filePath: string): string {
        const ranges = this.parse(filePath);

        let result = 0;

        let sortedRanges = ranges.sort((a, b) => a.start - b.start);
        let mergedRanges = [];

        for (const range of sortedRanges) {
            if (mergedRanges.length === 0 || mergedRanges[mergedRanges.length - 1].end < range.start) {
                mergedRanges.push(range);
            } else {
                mergedRanges[mergedRanges.length - 1].end = Math.max(mergedRanges[mergedRanges.length - 1].end, range.end);
            }
        }

        for (const range of mergedRanges) {
            result += range.end - range.start + 1;
        }       

        return String(result);
    }

    
    private parse(filePath: string): Range[] {
        const lines = readInputLinesFromPath(filePath);
        const separatorIndex = lines.findIndex(line => line.trim() === '');
        
        const ranges: Range[] = lines
            .slice(0, separatorIndex)
            .map(line => {
                const [start, end] = line.split('-').map(Number);
                return { start, end };
            });
        
        return ranges;
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