# Advent of Code - TypeScript Solutions

Advent of Code solutions implemented in TypeScript.

## Getting Started

### Prerequisites

- Node.js (v18 or higher recommended)
- npm (comes with Node.js)

### Installation

1. Install dependencies:
```bash
npm install
```

## Usage

### Running Solutions

To run a solution, use one of these commands:

```bash
npm start
# or
npm run dev
```

Both commands use `ts-node` to run TypeScript directly without compilation.

### Switching Between Days

Edit `src/main.ts` to select which day to run:

```typescript
const day: AoCTest = new Day1A();  // Run Day 1 Part A
// const day: AoCTest = new Day1B(); // Run Day 1 Part B
```

### Test vs Real Input

In `src/main.ts`, change the `execute()` parameter:

```typescript
const result = day.execute(false); // false = real input, true = test input
```

## Building

To compile TypeScript to JavaScript:

```bash
npm run build
```

This will output compiled files to the `dist/` directory.

## License

ISC

