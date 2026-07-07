// eslint-rules/raw-text-parser.js
// Trivial parser for raw-text files (markdown, etc.). Produces an empty Program
// AST so that raw-text-scanning rules can run on the full source text.
function locAt(text, idx) {
  const prefix = text.slice(0, idx);
  const parts = prefix.split(/\r?\n/);
  return { line: parts.length, column: parts[parts.length - 1].length };
}

function computeFencedLines(text) {
  const lines = text.split(/\r?\n/);
  let inFence = false;
  let fenceChar = "";
  let fenceLen = 0;
  const fenced = new Set();
  lines.forEach((line, i) => {
    const lineNum = i + 1;
    const m = line.match(/^[ \t]*(`{3,}|~{3,})(.*)$/);
    if (m) {
      const ch = m[1][0];
      const len = m[1].length;
      if (!inFence) {
        inFence = true;
        fenceChar = ch;
        fenceLen = len;
        fenced.add(lineNum);
      } else if (ch === fenceChar && len >= fenceLen && /^\s*$/.test(m[2])) {
        inFence = false;
        fenceChar = "";
        fenceLen = 0;
        fenced.add(lineNum);
      } else {
        fenced.add(lineNum);
      }
    } else if (inFence) {
      fenced.add(lineNum);
    }
  });
  return fenced;
}

function extractComments(text, fencedLines) {
  const comments = [];
  const re = /<!--([\s\S]*?)-->/g;
  let m;
  while ((m = re.exec(text)) !== null) {
    const start = m.index;
    const end = m.index + m[0].length;
    const startLine = locAt(text, start).line;
    if (fencedLines.has(startLine)) continue;
    comments.push({
      type: "Block",
      value: m[1],
      range: [start, end],
      loc: { start: locAt(text, start), end: locAt(text, end) },
    });
  }
  return comments;
}

module.exports = {
  parseForESLint(text) {
    const lineCount = text.split(/\r?\n/).length;
    const fencedLines = computeFencedLines(text);
    return {
      ast: {
        type: "Program",
        sourceType: "module",
        body: [],
        comments: extractComments(text, fencedLines),
        tokens: [],
        range: [0, text.length],
        loc: {
          start: { line: 1, column: 0 },
          end: { line: Math.max(lineCount, 1), column: 0 },
        },
      },
      services: { isRawText: true },
      scopeManager: null,
    };
  },
};
