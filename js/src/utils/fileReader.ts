import * as fs from 'fs';
import * as path from 'path';

const testPath = path.join(__dirname, '../../tests/2025/');

export function readInput(day: number, isTest: boolean = false): string {
    const filename = isTest ? `${day}_test.txt` : `${day}.txt`;
    const filePath = path.join(testPath, filename);
    return fs.readFileSync(filePath, 'utf-8').trim();
}

export function readInputLines(day: number, isTest: boolean = false): string[] {
    return readInput(day, isTest).split('\n');
}

export function readInputFromPath(filePath: string): string {
    return fs.readFileSync(filePath, 'utf-8').trim();
}

export function readInputLinesFromPath(filePath: string): string[] {
    return readInputFromPath(filePath).split('\n');
}

