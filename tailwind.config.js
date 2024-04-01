/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./login/**/*.{html,js,ftl}"],
  theme: {
    extend: {
      fontFamily: {
        Jakarta: ["Plus Jakarta Sans", "sans-serif"],
      },
    },
  },
  plugins: [],
  // safelist: [
  //   {
  //     pattern: /.*/,
  //   }
  // ]
}
