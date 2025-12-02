import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';

export class Day2B {
    private run(filePath: string): string {
        const ranges = this.parse(filePath);

        const sum = ranges.flatMap(([start, end]) => 
            Array.from({ length: end - start + 1 }, (_, i) => start + i)
        )
        .filter(num => this.isInvalid(num))
        .reduce((acc, num) => acc + num, 0);

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
        const str = String(item);

        for (let i = Math.floor(str.length / 2); i >= 1; i--) {
            if (str.length % i === 0) {
                const pattern = str.slice(0, i);
                const numSlices = str.length / i;
                
                let allMatch = true;
                for (let j = 1; j < numSlices; j++) {
                    if (str.slice(j * i, (j + 1) * i) !== pattern) {
                        allMatch = false;
                        break;
                    }
                }
                
                if (allMatch) {
                    return true;
                }
            }
        }

        return false;
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