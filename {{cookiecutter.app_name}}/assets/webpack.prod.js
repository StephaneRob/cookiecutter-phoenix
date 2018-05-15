const merge = require('webpack-merge');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin');
const common = require('./webpack.common.js');

module.exports = (env, options) => {
  return merge(common(env, options), {
    plugins: [
      new UglifyJSPlugin(),
    ],
  });
};
