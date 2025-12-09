import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';
import * as fs from 'fs';

export class Day6B {
    private run(filePath: string): string {
        const { numbersAsStrings, commands } = this.parse(filePath);
        let result = 0;

        for (let i = 0; i < commands.length; i++) {
            let command = commands[i];
            let numbersAsString = numbersAsStrings[i];
            let numbers = this.buildNumber(numbersAsString);

            let res = numbers[0];
            for (let j = 1; j < numbers.length; j++) {
                if (command === '+') {
                    res += numbers[j];
                } else if (command === '*') {
                    res *= numbers[j];
                }
            }
            result += res;
        }

        return String(result);
    }
    private buildNumber(numbers: string[]): number[] {
        let newNumbers: string[] = [];

        let count = numbers.length;
        for (let i = count - 1; i >= 0; i--) {
            for(const num of numbers) {
                if (num[i] !== ' ') {
                    newNumbers[i] = (newNumbers[i] ?? "") + num[i];
                }
            }
        }

        return newNumbers.map(str => Number(str)).filter(num => !isNaN(num));
    }
    
    private parse(filePath: string): { numbersAsStrings: string[][], commands: string[] } {
        // Read file without trimming to preserve trailing spaces
        const fileContent = fs.readFileSync(filePath, 'utf-8');
        const lines = fileContent.split('\n').filter(line => line.length > 0);
        
        const numberLines = lines.slice(0, -1);
        const commandLine = lines[lines.length - 1];
        
        const columnWidths: number[] = [];
        let inColumn = false;
        let columnWidth = 0;

        for (let i = 1; i < commandLine.length; i++) {
            const char = commandLine[i];
            if (char === ' ') {
                inColumn = true;
                columnWidth++;
                if (i == commandLine.length - 1) {
                    columnWidths.push(columnWidth+1);
                }
            } else if (inColumn && (char === '+' || char === '*')) {
                columnWidths.push(columnWidth);
                columnWidth = 0;
                inColumn = false;
            } else if (char === '+' || char === '*') {
                inColumn = false;
                columnWidth = 0;
            }
        }

        const numbers: string[][] = [];
        
        for (const line of numberLines) {
            const row: string[] = [];
            let pos = 0;
            for (const width of columnWidths) {
                const column = line.substring(pos, pos + width);
                row.push(column);
                pos += width+1;
            }
            numbers.push(row);
        }

        const transposedNumbers: string[][] = [];
        if (numbers.length > 0) {
            for (let col = 0; col < numbers[0].length; col++) {
                transposedNumbers[col] = numbers.map(row => row[col]);
            }
        }

        const commands: string[] = commandLine
            .trim()
            .split(/\s+/)
            .filter(cmd => cmd !== '');

        return { numbersAsStrings: transposedNumbers, commands };
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