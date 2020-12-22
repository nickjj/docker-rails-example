// We're using a custom node_modules directory which is defined in .yarnrc.
const node_modules = '/node_modules'

module.exports = {
  resolveLoader: {modules: [node_modules]}
}
