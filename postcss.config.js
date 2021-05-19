module.exports = {
  plugins: [
    require('postcss-import'),
    require('tailwindcss')('app/packs/stylesheets/tailwind.config.js'),
    require('autoprefixer'),
    require('postcss-flexbugs-fixes'),
  ]
}
