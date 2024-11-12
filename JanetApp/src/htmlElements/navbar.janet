# This file holds the implementation of the navbar.
# the navbar is a menu found at the top of the page.

# These are html/css class definitions
# This is a useful shorthand for defining your own reusable Html tags.
(def navbar-container :nav.fixed.w-full.z-20.top-0.start-0.shadow-md)
(def navbar-brand-container :div.max-w-screen-xl.flex.flex-wrap.items-center.justify-center.mx-auto.p-4)
(def navbar-brand-link :a.flex.items-center.space-x-3.rtl:space-x-reverse)
(def navbar-brand-logo :img.h-8)
(def navbar-brand-name :span.self-center.text-2xl.font-semibold.whitespace-nowrap)
(def navbar-button-container :div.flex.justify-center.pb-2)
(def navbar-button :button.inline-flex.items-center.p-2.w-10.h-10.justify-center.text-sm.rounded-lg.md:hidden.focus:outline-none.focus:ring-2.focus:ring-gray-200.dark:text-gray-400.dark:hover:bg-gray-700.dark:focus:ring-gray-600)
(def navbar-menu-container :div.items-center.justify-center.hidden.w-full.md:flex.md:w-auto.md:order-1.pb-2)
(def navbar-menu-list :ul.bg-pastgreen.flex.flex-col.p-4.md:p-0.mt-4.font-medium.border.border-gray-100.rounded-lg.md:space-x-8.rtl:space-x-reverse.md:flex-row.md:mt-0.md:border-0.dark:border-gray-700)
(def navbar-menu-links :a.block.py-2.px-3.rounded.hover:cursor-pointer.hover:shadow-sm)

(def navbar
  [navbar-container {:class "bg-red-500 text-gray-900 rounded-b-lg"}
   # The brand name and logo.
   [navbar-brand-container
    [navbar-brand-link
     [navbar-brand-logo {}]
     [navbar-brand-name {:class "text-gray-900"}
      "Template Site"]]]
   # The button that toggles the menu on mobile.
   [navbar-button-container
    [navbar-button {:class "text-gray-900 hover:bg-white" :data-collapse-toggle "navbar" :type "button" :aria-controls "navbar" :aria-expanded "false"}
     [:svg {:class "h-6 w-6" :aria-hidden "true" :role "img" :xmlns "http://www.w3.org/2000/svg" :viewBox "0 0 24 24"}
      [:path {:fill "currentColor" :d "M4 6h16M4 12h16M4 18h16"}]] "Menu"]]
   # The menu itself.
   [navbar-menu-container {:id "navbar"}
    [navbar-menu-list
     [:li [navbar-menu-links {:class "text-gray-900 hover:bg-white" :href "/"} "Home"]]
     [:li [navbar-menu-links {:class "text-gray-900 hover:bg-white" :href ""} "Regions"]]
     [:li [navbar-menu-links {:class "text-gray-900 hover:bg-white" :href "/gyms"} "Gyms"]]]]])
