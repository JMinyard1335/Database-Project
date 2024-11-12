# This file is used to define a reusable card html element.
(use joy)

# This defines the style classes of the card
(def- card-link :a.flex.flex-col.items-center.bg-white.border.border-gray-200.rounded-lg.shadow.md:flex-row.md:max-w-xl.hover:bg-gray-100.dark:border-gray-700.dark:bg-gray-800.dark:hover:bg-gray-700.m-4.w-full)
(def- card-image :img.object-cover.w-full.rounded-t-lg.h-96.md:h-auto.md:w-48.md:rounded-none.md:rounded-s-lg)
(def- card-body :div.flex.flex-col.justify-between.p-4.leading-normal)
(def- card-title :h5.mb-2.text-2xl.font-bold.tracking-tight.text-gray-900.dark:text-white)
(def- card-type :h3)
(def- card-region :h3)
(def- card-leader :h3)
(def- card-badge :h3)
(def- card-description :p.mb-3.font-normal.text-gray-700.dark:text-gray-400)

# This function takes a struct and a corrosponding flag
# The flag determnies the returned html card.
# The currently implemented flags are:
# :p for a pokemon card
# :g for a gym card
# EXAMPLE Pokemon:
# (def bulbasaur (create-pokemon "1" "bulbasaur" "Kanto" ["grass" "posion"] "path/to/image"))
# (card bulbasur :p)
# Example Gym:
# (def gym  (create-gym "Violet Gym" "Johto" ["Falconer"] "Zephyr" "images/Gyms/Johto/gym1.png"))
# (card gym :g)
(defn card [struct &opt flags]
  (var g-flag-set false)
  (var p-flag-set false)
  (var res nil)
  
  (when flags
    (set g-flag-set (string/check-set flags :g))
    (set p-flag-set (string/check-set flags :p)))

  # To change the layout of the pokemon display modify the following block
  (if p-flag-set
    (set res
	 [card-link {:href "#"}
	  [card-image {:src (get struct :image) :alt ""}]
	  [card-body
	   [card-title (get struct :name)]
	   [:h3 {:class ""} "Types: "]
	   [card-type {:class "ml-4"}(:list-types struct)]
	   [card-region (string/format "Region: %s" (get struct :region))]
	   [card-description (get struct :description)]]]))

  # To change the layout of the gym display modify the following block
  (if g-flag-set
    (set res
	 [card-link {:href "#"}
	  [card-image {:src (get struct :image) :alt ""}]
	  [card-body
	   [card-title (get struct :name)]
	   [card-type (string/format "Type: %s" (get struct :typ))]
	   [card-region (string/format "Region: %s" (get struct :region))]
	   [card-badge (get struct :badge)]
	   [card-leader (:list-leader struct)]]]))
  
  res)
  
