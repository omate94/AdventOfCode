import { Day1A } from './2025/Day1A';
import { Day1B } from './2025/Day1B';
import { Day2A } from './2025/Day2A';
import { Day2B } from './2025/Day2B';
import { Day3A } from './2025/Day3A';
import { Day3B } from './2025/Day3B';
import { Day4A } from './2025/Day4A';
import { Day4B } from './2025/Day4B';
import { Day5A } from './2025/Day5A';
import { Day5B } from './2025/Day5B';
import { Day6A } from './2025/Day6A';
import { Day6B } from './2025/Day6B';
import { Day7A } from './2025/Day7A';
import { Day7B } from './2025/Day7B';
import { Day8A } from './2025/Day8A';
import { Day8B } from './2025/Day8B';
import { Day9A } from './2025/Day9A';

interface AoCTest {
    execute(test: boolean): string;
}

function main() {

//    const day: AoCTest = new Day1A();
//    const day: AoCTest = new Day1B();
//    const day: AoCTest = new Day2A();
//    const day: AoCTest = new Day2B();
//    const day: AoCTest = new Day3A();
//    const day: AoCTest = new Day3B();
//    const day: AoCTest = new Day4A();
//    const day: AoCTest = new Day4B();
//    const day: AoCTest = new Day5A();
//    const day: AoCTest = new Day5B();
//    const day: AoCTest = new Day6A();
//    const day: AoCTest = new Day6B();
//    const day: AoCTest = new Day7A();
//    const day: AoCTest = new Day7B();
//    const day: AoCTest = new Day8A();
//    const day: AoCTest = new Day8B();
    const day: AoCTest = new Day9A();
    
    const startTime = performance.now();
    const result = day.execute(false);
    const endTime = performance.now();
    
    console.log('Result:', result);
    console.log(`Time: ${(endTime - startTime).toFixed(2)}ms`);
}

main();

