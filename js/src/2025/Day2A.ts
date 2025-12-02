import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';

export class Day2A {
    private run(filePath: string): string {
        const ranges = this.parse(filePath);

        let sum = 0;

        for (const range of ranges) {
            const [start, end] = range;
            for (let num = start; num <= end; num++) {
                if (this.isInvalid(num)) {
                    sum += num;
                }
            }
        }

        return String(sum);
    }

    private parse(filePath: string): number[][] {
        return readInputLinesFromPath(filePath)
            .flatMap(line => 
                line.split(',')
                    .map(range => range.split('-').map(Number))
            );
    }

    private isInvalid(item: number): boolean {
        let str = String(item);

        if (str.length % 2 !== 0) {
            return false;
        }

        let firstHalf = str.slice(0, str.length / 2);
        let secondHalf = str.slice(str.length / 2);

        return firstHalf === secondHalf;
    }

    execute(test: boolean): string {
        const testPath = path.join(__dirname, '../../tests/2025/');
        if (test) {
            return this.run(path.join(testPath, '2_test.txt'));
        } else {
            return this.run(path.join(testPath, '2.txt'));
        }
    }
}