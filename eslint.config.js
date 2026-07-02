// eslint.config.js
// Enforces: STD-DOC-003 (Unicode Policy), STD-DOC-002 (Markdown Standard)
const unicodePolicy = require("./eslint-rules/unicode-policy.js");
const rawTextParser = require("./eslint-rules/raw-text-parser.js");

module.exports = [
  {
    ignores: [
      "node_modules/**",
      "scripts/**",
    ],
  },

  {
    plugins: { "unicode-policy": unicodePolicy },
    files: ["**/*.md"],
    languageOptions: { parser: rawTextParser },
    rules: {
      "unicode-policy/emoji-in-md": "error",
      "unicode-policy/unicode-graphics-in-md": "error",
    },
  },
];
