import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';

enum Direction {
    Left = 'L',
    Right = 'R'
}

interface Action {
    direction: Direction;
    clicks: number;
}

export class Day1B {
    private run(filePath: string): string {
        const actions = this.parse(filePath);
        
        let start = 50;
        let count = 0;
        
        for (const action of actions) {
            const zeros = Math.floor(action.clicks / 100);
            const clicks = action.clicks % 100;
            count += zeros;
            console.log(`Start: ${start}, Clicks: ${clicks}, Zeros: ${zeros}, Count: ${count}`);
            
            switch (action.direction) {
                case Direction.Left:
                    start = start - clicks;
                    break;
                case Direction.Right:
                    start = start + clicks;
                    break;
            }
            console.log(`new Start: ${start}`);
            
            if (start === 0) {
                count += 1;
            } else if (start < 0) {
                if (start + clicks !== 0) {
                    count += 1;
                }
                start = 100 - Math.abs(start);
            } else if (start > 99) {
                start = 0 + start - 100;
                count += 1;
            }
            console.log(`fixed Start: ${start}, new Count: ${count}`);
            console.log('    ');
        }
        
        return String(count);
    }
    
    private parse(filePath: string): Action[] {
        const lines = readInputLinesFromPath(filePath);
        return lines.map(line => {
            const dir = line[0] === 'L' ? Direction.Left : Direction.Right;
            const num = parseInt(line.slice(1), 10);
            return { direction: dir, clicks: num };
        });
    }
    
    execute(test: boolean): string {
        const testPath = path.join(__dirname, '../../tests/2025/');
        if (test) {
            return this.run(path.join(testPath, '1_test.txt'));
        } else {
            return this.run(path.join(testPath, '1.txt'));
        }
    }
}

