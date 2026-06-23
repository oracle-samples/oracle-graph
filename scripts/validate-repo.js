#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
const errors = [];

function walk(dir, predicate, out = []) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      walk(fullPath, predicate, out);
    } else if (!predicate || predicate(fullPath)) {
      out.push(fullPath);
    }
  }
  return out;
}

function rel(filePath) {
  return path.relative(root, filePath);
}

function checkNoDsStore() {
  for (const file of walk(root, filePath => path.basename(filePath) === '.DS_Store')) {
    errors.push(`Remove macOS system file: ${rel(file)}`);
  }
}

function checkJsonFiles() {
  for (const file of walk(root, filePath => /\.(ipynb|dsnb|json)$/i.test(filePath))) {
    try {
      const parsed = JSON.parse(fs.readFileSync(file, 'utf8'));
      if (/\.ipynb$/i.test(file)) {
        for (const [index, cell] of (parsed.cells || []).entries()) {
          if (Array.isArray(cell.outputs) && cell.outputs.length > 0) {
            errors.push(`Clear notebook outputs: ${rel(file)} cell ${index}`);
          }
          if (cell.execution_count !== null && cell.execution_count !== undefined) {
            errors.push(`Clear notebook execution count: ${rel(file)} cell ${index}`);
          }
        }
      }
    } catch (error) {
      errors.push(`Invalid JSON in ${rel(file)}: ${error.message}`);
    }
  }
}

function checkMarkdownLinks() {
  const linkPattern = /\[[^\]\n]+\]\(([^)\n]+)\)/g;
  for (const file of walk(root, filePath => /\.md$/i.test(filePath))) {
    const text = fs.readFileSync(file, 'utf8');
    let match;
    while ((match = linkPattern.exec(text))) {
      let href = match[1].trim();
      if (!href || href.startsWith('#') || /^[a-z][a-z0-9+.-]*:/i.test(href)) {
        continue;
      }
      href = href.split('#')[0];
      if (!href) {
        continue;
      }
      const target = path.resolve(path.dirname(file), href);
      if (!fs.existsSync(target)) {
        errors.push(`Broken local link in ${rel(file)}: ${match[1]}`);
      }
    }
  }
}

function checkRequiredReadmes() {
  const required = [
    'README.md',
    'property-graph/README.md',
    'property-graph/26ai/README.md',
    'property-graph/26ai/get-started/README.md',
    'property-graph/26ai/demos/README.md',
    'property-graph/19c/README.md',
    'property-graph/19c/get-started/README.md',
    'property-graph/19c/demos/README.md',
    'property-graph/docs/README.md',
    'knowledge-graph/README.md',
    'knowledge-graph/demo/README.md',
    'rdf/README.md',
    'shared/README.md',
    'shared/datasets/bank_graph/README.md'
  ];

  for (const file of required) {
    if (!fs.existsSync(path.join(root, file))) {
      errors.push(`Missing README: ${file}`);
    }
  }
}

checkNoDsStore();
checkJsonFiles();
checkMarkdownLinks();
checkRequiredReadmes();

if (errors.length > 0) {
  console.error(`Repository validation failed with ${errors.length} issue(s):`);
  for (const error of errors) {
    console.error(`- ${error}`);
  }
  process.exit(1);
}

console.log('Repository validation passed.');
