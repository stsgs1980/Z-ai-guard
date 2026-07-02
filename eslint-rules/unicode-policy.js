// eslint-rules/unicode-policy.js
// Enforces STD-DOC-003: Unicode Policy (no emoji / Unicode graphics in documentation)

function stripFencedCode(text) {
  const lines = text.split(/\r?\n/);
  let inFence = false;
  let fenceChar = "";
  let fenceLen = 0;
  return lines
    .map((line) => {
      const m = line.match(/^[ \t]*(`{3,}|~{3,})(.*)$/);
      if (m) {
        const ch = m[1][0];
        const len = m[1].length;
        if (!inFence) {
          inFence = true;
          fenceChar = ch;
          fenceLen = len;
          return "";
        }
        if (ch === fenceChar && len >= fenceLen && /^\s*$/.test(m[2])) {
          inFence = false;
          fenceChar = "";
          fenceLen = 0;
          return "";
        }
      }
      if (inFence) return "";
      return line;
    })
    .join("\n");
}

module.exports = {
  meta: {
    name: "unicode-policy",
    version: "1.0.0",
  },
  processors: {},
  rules: {
    "emoji-in-md": {
      meta: {
        type: "suggestion",
        docs: {
          description: "Disallow emoji in Markdown documentation (STD-DOC-003 section 4.1, level [C])",
          category: "Unicode Policy",
          recommended: true,
        },
        messages: {
          emojiInMd: "Emoji are prohibited in documentation [C]. Use text tags like [OK], [FAIL] instead. (STD-DOC-003 section 4.1)",
        },
      },
      create(context) {
        const emojiPattern = /[\u{1F600}-\u{1F64F}\u{1F300}-\u{1F5FF}\u{1F680}-\u{1F6FF}\u{1F1E0}-\u{1F1FF}\u{2600}-\u{27BF}\u{FE00}-\u{FEFF}\u{1F900}-\u{1F9FF}\u{1FA00}-\u{1FA6F}\u{1FA70}-\u{1FAFF}\u{2702}-\u{27B0}]/u;

        return {
          Program(node) {
            const sourceCode = context.sourceCode || context.getSourceCode();
            const text = sourceCode.getText();
            const textWithoutCodeBlocks = stripFencedCode(text);
            const lines = textWithoutCodeBlocks.split("\n");
            lines.forEach((line, index) => {
              if (emojiPattern.test(line)) {
                context.report({ loc: { line: index + 1, column: 0 }, messageId: "emojiInMd" });
              }
            });
          },
        };
      },
    },

    "unicode-graphics-in-md": {
      meta: {
        type: "suggestion",
        docs: {
          description: "Disallow Unicode graphic characters in Markdown documentation (STD-DOC-003 section 4.1, level [W])",
          category: "Unicode Policy",
          recommended: true,
        },
        messages: {
          unicodeGraphicsInMd: "Unicode graphic characters are prohibited in documentation [W]. Use ASCII art in code blocks or text alternatives. (STD-DOC-003 section 4.1)",
        },
      },
      create(context) {
        const unicodeGraphicsPattern = /[\u{2500}-\u{257F}\u{2580}-\u{259F}\u{25A0}-\u{25FF}\u{2190}-\u{21FF}\u{2200}-\u{22FF}\u{2300}-\u{23FF}]/u;

        return {
          Program(node) {
            const sourceCode = context.sourceCode || context.getSourceCode();
            const text = sourceCode.getText();
            const textWithoutCodeBlocks = stripFencedCode(text);
            const lines = textWithoutCodeBlocks.split("\n");
            lines.forEach((line, index) => {
              if (unicodeGraphicsPattern.test(line)) {
                context.report({ loc: { line: index + 1, column: 0 }, messageId: "unicodeGraphicsInMd" });
              }
            });
          },
        };
      },
    },
  },
};
