const webpack = require('webpack');
const path = require('path');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const Clean = require('clean-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');

const SRC_PATH = 'src';
const SRC_ABSOLUTE_PATH = path.join(__dirname, SRC_PATH);
const INDEX_HTML_TEMPLATE_ABSOLUTE_PATH = path.join(SRC_ABSOLUTE_PATH, 'index.html');

const DIST_PATH = 'dist';
const DIST_ABSOLUTE_PATH = path.join(__dirname, DIST_PATH);

const APPLICATION_BUNDLE_FILENAME = 'app-[hash].js';
const CSS_BUNDLE_FILENAME = 'app-[hash].css';

const plugins = [
  new ExtractTextPlugin({
    filename: CSS_BUNDLE_FILENAME,
    disable: false,
    allChunks: true
  }),
  new Clean([DIST_PATH]),
  new HtmlWebpackPlugin({
    template: INDEX_HTML_TEMPLATE_ABSOLUTE_PATH,
    inject: 'body'
  })
];

module.exports = (env) => {
  if (env && env.dist) {
    plugins.push(new webpack.optimize.UglifyJsPlugin({
      beautify: false,
      mangle: true,
      comments: false
    }));

    plugins.push(new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify('production')
    }));
  }
  return {
    context: SRC_ABSOLUTE_PATH,
    entry: './index',
    output: {
      path: DIST_ABSOLUTE_PATH,
      filename: APPLICATION_BUNDLE_FILENAME
    },
    module: {
      rules: [{
        test: /\.js$/,
        include: SRC_ABSOLUTE_PATH,
        use: [{
          loader: 'babel-loader'
        }, {
          loader: 'eslint-loader',
          options: {
            emitWarning: true
          }
        }]
      }, {
        test: /\.sass$/,
        include: SRC_ABSOLUTE_PATH,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: 'css-loader?minimize!sass-loader'
        })
      }, {
        test: /\.(jpe?g|png|gif|svg)$/,
        include: SRC_ABSOLUTE_PATH,
        use: 'file-loader'
      }]
    },
    plugins,
    devServer: {
      contentBase: DIST_PATH,
      host: '0.0.0.0',
      historyApiFallback: true
    }
  };
};
