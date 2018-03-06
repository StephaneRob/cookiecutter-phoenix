const path = require('path');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
  entry: {
    main: [
      './js/app.js',
      './css/app.scss',
    ],
  },
  output: {
    filename: 'app.js',
    path: path.resolve(__dirname, '../priv/static/js'),
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
      {
        test: /\.(scss|sass|css)$/i,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [
            { loader: 'css-loader', options: { minimize: true } },
            { loader: 'postcss-loader', options: { sourceMap: true } },
            'resolve-url-loader',
            { loader: 'sass-loader', options: { sourceMap: true } },
          ],
        }),
      },
    ],
  },

  plugins: [
    new ExtractTextPlugin('../css/app.css'),
    new CopyWebpackPlugin([{ from: 'static/', to: '../' }]),
  ],
};
