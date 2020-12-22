const { environment } = require('@rails/webpacker')

// This example is taken from the Webpacker docs at:
//   https://github.com/rails/webpacker/blob/master/docs/webpack.md
const custom = require('./custom')
environment.config.merge(custom)

module.exports = environment
