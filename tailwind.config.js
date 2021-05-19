module.exports = {
  mode: "jit",
  purge: {
    enabled: ["production"].includes(process.env.NODE_ENV),
    content: [
      "./**/*.html.erb",
      "./app/helpers/**/*.rb",
      "./app/packs/**/*.js",
    ]
  }
};
