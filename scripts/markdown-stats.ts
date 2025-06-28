import { readFileSync } from 'fs';

export interface Stats {
  readonly lines: number;
  readonly words: number;
  readonly characters: number;
}

export function computeStats(content: string): Stats {
  const lines = content.split(/\r?\n/).length;
  const words = content.trim().split(/\s+/).filter(Boolean).length;
  const characters = content.length;
  return { lines, words, characters };
}

function main(args: readonly string[]): void {
  const files = args.length > 0 ? args : ['README.md'];
  let exitCode = 0;

  for (const file of files) {
    try {
      const text = readFileSync(file, 'utf8');
      const stats = computeStats(text);
      console.log(`${file}: ${stats.lines} lines, ${stats.words} words, ${stats.characters} chars`);
    } catch {
      console.error(`Missing file: ${file}`);
      exitCode = 1;
    }
  }

  if (exitCode !== 0) {
    process.exitCode = exitCode;
  }
}

if (require.main === module) {
  main(process.argv.slice(2));
}
