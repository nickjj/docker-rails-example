// We're using a custom node_modules directory which is defined in .yarnrc.
const node_modules = '/node_modules'

const { webpackConfig, merge } = require('@rails/webpacker')
const customConfig = {
  devtool: 'eval-cheap-module-source-map',
  plugins: [],
  resolve: {
    extensions: ['.css']
  },
  resolveLoader: {modules: [node_modules]}
}

module.exports = merge(webpackConfig, customConfig)
