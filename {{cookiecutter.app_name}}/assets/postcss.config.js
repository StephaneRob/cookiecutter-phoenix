const autoprefixer = require('autoprefixer');
const precss = require('precss');
const tailwindcss = require('tailwindcss');

module.exports = {
  plugins: [
    precss,
    autoprefixer,
    tailwindcss('./tailwind.js'),
  ],
};
