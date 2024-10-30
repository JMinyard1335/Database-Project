// This config file sets up the tailwind package.
// This project used the node version since it will make use of other node projects like flowbite.
/** @type {import('tailwindcss').Config} */
module.exports = {
    // Content is the content to search for tailwind classes
    content: ["./src/templates/*.janet",
	      "./src/htmlElements/*.janet",
	      "./node_modules/flowbite/**/*.js"],
    // Theme allows us to extend the default tailwind theme
  theme: {
    extend: {},
  },
    // Plugins allow us to add additional functionality to tailwind
    plugins: [
	require('flowbite/plugin')
  ],
}

