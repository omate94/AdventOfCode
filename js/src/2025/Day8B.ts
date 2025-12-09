import { readInputLinesFromPath } from '../utils/fileReader';
import * as path from 'path';

interface Distance {
    distance: number;
    junction1: Junction;
    junction2: Junction;
}

interface Junction {
    id: number;
    junction: number[];
}

export class Day8B {
    private run(filePath: string): string {
        let junctions = this.parse(filePath);

        let distances: Distance[] = [];
        for (let i = 0; i < junctions.length; i++) {
            for (let j = i + 1; j < junctions.length; j++) {
                distances.push({
                    distance: this.calculateDistance(junctions[i].junction, junctions[j].junction),
                    junction1: junctions[i],
                    junction2: junctions[j]
                });
            }
        }

        distances.sort((a, b) => a.distance - b.distance);
       
        let lastTwoX = [0,0];
        let circuits = Array<Set<number>>();
        for (let i = 0; i < distances.length; i++) {
            const distance = distances[i];
            const junction1Id = distance.junction1.id;
            const junction2Id = distance.junction2.id;
            
            const circuitIndexOf1 = circuits.findIndex(circuit => 
                circuit.has(junction1Id)
            );

            const circuitIndexOf2 = circuits.findIndex(circuit => 
                circuit.has(junction2Id)
            );

            if (circuitIndexOf1 === -1 && circuitIndexOf2 === -1) {
                lastTwoX = [distance.junction1.junction[0], distance.junction2.junction[0]];
                circuits.push(new Set<number>([junction1Id, junction2Id]));
            } else if (circuitIndexOf1 !== -1 && circuitIndexOf2 !== -1) {
                if (circuitIndexOf1 !== circuitIndexOf2) {
                    lastTwoX = [distance.junction1.junction[0], distance.junction2.junction[0]];
                    for (const id of circuits[circuitIndexOf2]) {
                        circuits[circuitIndexOf1].add(id);
                    }
                    circuits.splice(circuitIndexOf2, 1);
                }
            } else if (circuitIndexOf1 !== -1) {
                lastTwoX = [distance.junction1.junction[0], distance.junction2.junction[0]];
                circuits[circuitIndexOf1].add(junction2Id);
            } else if (circuitIndexOf2 !== -1) {
                lastTwoX = [distance.junction1.junction[0], distance.junction2.junction[0]];
                circuits[circuitIndexOf2].add(junction1Id);
            }
        }

        return String(lastTwoX[0] * lastTwoX[1]);
    }

    private calculateDistance(junction1: number[], junction2: number[]): number {
        let a = Math.pow((junction1[0] ?? 0) - (junction2[0] ?? 0), 2);
        let b = Math.pow((junction1[1] ?? 0) - (junction2[1] ?? 0), 2);
        let c = Math.pow((junction1[2] ?? 0) - (junction2[2] ?? 0), 2);
        return Math.abs(Math.sqrt(a + b + c));
    }

    private parse(filePath: string): Junction[] {
        return readInputLinesFromPath(filePath)
            .map((line, index): Junction => ({
                id: index,
                junction: line.split(',').map(num => Number(num.trim()))
            }));
    }

    execute(test: boolean): string {
        const testPath = path.join(__dirname, '../../tests/2025/');
        if (test) {
            return this.run(path.join(testPath, '8_test.txt'));
        } else {
            return this.run(path.join(testPath, '8.txt'));
        }
    }
}