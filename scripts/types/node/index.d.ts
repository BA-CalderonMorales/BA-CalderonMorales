declare var require: any;
declare var module: any;
declare var process: { argv: string[]; exitCode?: number };

declare module 'fs' {
  export function readFileSync(path: string, encoding: string): string;
}

declare module 'assert' {
  export namespace strict {
    function equal(actual: unknown, expected: unknown): void;
  }
  function equal(actual: unknown, expected: unknown): void;
}
