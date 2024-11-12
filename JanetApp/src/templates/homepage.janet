(use joy)
(use ../htmlElements/navbar)
(use ../htmlElements/search)
(use ../htmlElements/card)

# The main page will just display all the pokemon in the database.
# This is subject to change.
(defn mainpage [pokecard-list]
  [:div {:class ""}
   [:div navbar]
   [:div search-form]
   [:div {:class "flex justify-center mt-4 mx-10"}
    [:div {:class "p-8 mt-4 w-1/2 bg-red-500 sm:w-3/4 md:w-1/2 lg:w-1/3 flex justify-center rounded-lg"}
     [:ul {:class "list-none justify-center w-full"}
      (foreach
       [p pokecard-list]
       [:li {:class "flex w-full justify-center"} (card p :p)])]]]
  ])
