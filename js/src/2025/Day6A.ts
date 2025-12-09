import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';


export class Day6A {
    private run(filePath: string): string {
        const { numbers, commands } = this.parse(filePath);
        let result = 0;

        for (let i = 0; i < numbers[0].length; i++) {
            let res = numbers[0][i];
            for (let j = 1; j < numbers.length; j++) {
                if (commands[i] === '+') {
                    res += numbers[j][i];
                } else if (commands[i] === '*') {
                    res *= numbers[j][i];
                }
            }
            result += res;
        }


        return String(result);
    }

    
    private parse(filePath: string): { numbers: number[][], commands: string[] } {
        const lines = readInputLinesFromPath(filePath);
        
        const numberLines = lines.slice(0, -1);
        const commandLine = lines[lines.length - 1];
        
        const numbers: number[][] = numberLines 
            .map(line => 
                line
                    .trim()
                    .split(/\s+/)
                    .map(Number)
            );
        
        const commands: string[] = commandLine
            .trim()
            .split(/\s+/)
            .filter(cmd => cmd !== '');
        
        return { numbers, commands };
    }

    execute(test: boolean): string {
        const testPath = path.join(__dirname, '../../tests/2025/');
        if (test) {
            return this.run(path.join(testPath, '6_test.txt'));
        } else {
            return this.run(path.join(testPath, '6.txt'));
        }
    }
}