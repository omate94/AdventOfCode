import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';

export class Day3B {
    private run(filePath: string): string {
        const banks = this.parse(filePath);

        let result = 0;

        for (let bank of banks) {
            let items = [];
            while(items.length < 12) {
                let nextItemIndex = this.findNextValidIndex(bank, items.length);
                if (nextItemIndex !== -1) {
                    items.push(bank[nextItemIndex]);
                    bank = bank.slice(nextItemIndex + 1);
                }
            }
            result += Number(items.join(''));
        }

        return String(result);
    }

    private findNextValidIndex(bank: number[], pos: number): number {
        for (let i = 9; i > 0; i--) {
            const index = bank.indexOf(i);
            const freeSpace = 12 - pos;
            if (index !== -1 && freeSpace <= bank.length - index) {
                return bank.indexOf(i);
            }
        }
        return -1;
    }
    
    private parse(filePath: string): number[][] {
        return readInputLinesFromPath(filePath)
            .map(line => 
                line.split('').map(Number)
            );
    }

    execute(test: boolean): string {
        const testPath = path.join(__dirname, '../../tests/2025/');
        if (test) {
            return this.run(path.join(testPath, '3_test.txt'));
        } else {
            return this.run(path.join(testPath, '3.txt'));
        }
    }
}