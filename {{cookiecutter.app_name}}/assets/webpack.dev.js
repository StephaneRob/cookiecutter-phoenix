const merge = require('webpack-merge');
const common = require('./webpack.common.js');

module.exports = (env, options) => {
  return merge(common(env, options), {});
};
