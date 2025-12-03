import { Day1A } from './2025/Day1A';
import { Day1B } from './2025/Day1B';
import { Day2A } from './2025/Day2A';
import { Day2B } from './2025/Day2B';
import { Day3A } from './2025/Day3A';
import { Day3B } from './2025/Day3B';

interface AoCTest {
    execute(test: boolean): string;
}

function main() {

 //   const day: AoCTest = new Day1A();
 //   const day: AoCTest = new Day1B();
 //   const day: AoCTest = new Day2A()  ;
 //   const day: AoCTest = new Day2B();
 //   const day: AoCTest = new Day3A();
     const day: AoCTest = new Day3B();
    
    const startTime = performance.now();
    const result = day.execute(false);
    const endTime = performance.now();
    
    console.log('Result:', result);
    console.log(`Time: ${(endTime - startTime).toFixed(2)}ms`);
}

main();

