import { computeStats } from './markdown-stats';
import { strict as assert } from 'assert';

const sample = 'one two three\nfour five';
const stats = computeStats(sample);

assert.equal(stats.lines, 2);
assert.equal(stats.words, 5);
assert.equal(stats.characters, sample.length);

console.log('markdown-stats tests passed');
