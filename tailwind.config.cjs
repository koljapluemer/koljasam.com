module.exports = {
  content: [
    "./src/**/*.{njk,md,html}",
    "./src/**/*.11ty.js",
    "./node_modules/flowbite/**/*.js"
  ],
  theme: {
    extend: {}
  },
  plugins: [require("flowbite/plugin")]
};
