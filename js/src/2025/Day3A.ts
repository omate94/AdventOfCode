import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';

export class Day3A {
    private run(filePath: string): string {
        const banks = this.parse(filePath);

        let result = 0;

        for (let bank of banks) {
            let firstBattery = -1;
            let secondBattery = -1;
            for (let i = 9; i >= 1; i--) {
                const index = bank.indexOf(i);
                if (index > -1) {
                    if (index !== bank.length - 1) {
                        firstBattery = i;
                        bank = bank.slice(index + 1);
                    } else {
                        secondBattery = i;
                        bank = bank.slice(0, -1);
                    }
                    break;
                }
            }

            for (let i = 9; i >= 1; i--) {
                const index = bank.indexOf(i);
                if (index > -1) {
                    if (firstBattery > 0) {
                        secondBattery = i;
                    } else {
                        firstBattery = i;
                    }
                    break;
                }
            }

            result += Number(String(firstBattery) + String(secondBattery));
        }

        return String(result);
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