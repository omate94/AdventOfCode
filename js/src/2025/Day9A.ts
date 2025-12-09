import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';

interface Point {
    x: number;
    y: number;
}

export class Day9A {
    private run(filePath: string): string {
        let points = this.parse(filePath);
        let result = 0;

        points.sort((a, b) => a.x - b.x);

        for (let i = 0; i < points.length - 1; i++) {
            for (let j = i + 1; j < points.length; j++) {
                let width = Math.abs(points[i].x - points[j].x) + 1;
                let height = Math.abs(points[i].y - points[j].y) + 1;
                let square = width * height;
                if (square > result) {
                    result = square;
                }
            }
        }
        
        return String(result);
    }

    
    private parse(filePath: string): Point[] {
        return readInputLinesFromPath(filePath)
            .map(line => {
                const [x, y] = line.split(',').map(Number);
                return { x, y };
            });
    }

    execute(test: boolean): string {
        const testPath = path.join(__dirname, '../../tests/2025/');
        if (test) {
            return this.run(path.join(testPath, '9_test.txt'));
        } else {
            return this.run(path.join(testPath, '9.txt'));
        }
    }
}