(use joy)
(use ../htmlElements/navbar)
(use ../htmlElements/card)
(use ../htmlElements/search)
(use ../testdata)

(defn gympage []
  [:div
   [:div {:class ""} navbar]
   [:div {:class ""} search-form]
   
   # Kanto Gym List 
   [:h1 {:class "font-bold text-center font-3xl"}"Kanto Gyms"]
   [:div {:class "flex justify-center mt-4 mx-10 overflow-x-auto"}
    [:div {:class "p-8 mt-4 w-full bg-red-500 flex justify-center rounded-lg"}
     [:ul {:class "flex list-none justify-center w-full"}
      (foreach
	[g (kanto-gym-list)]
	[:li {:class "flex w-full justify-center"} (card g :g)])]]]
   
   # Johto Gyms
   [:h1 {:class "font-bold text-center font-3xl"}"Johto Gyms"]
   [:div {:class "flex justify-center mt-4 mx-10 overflow-x-auto bg-red-500 "}
    [:div {:class "p-8 mt-4 w-full flex justify-center rounded-lg"}
     [:ul {:class "flex list-none justify-center w-full"}
      (foreach
	[g (johto-gym-list)]
	[:li {:class "flex w-full justify-center"} (card g :g)])]]]
   
   # Hoenn Gyms
   [:h1 {:class "font-bold text-center font-3xl"}"Hoenn Gyms"]
   [:div {:class "flex justify-center mt-4 mx-10"}
    [:div {:class "p-8 mt-4 w-full bg-red-500 flex justify-center rounded-lg"}
     [:ul {:class "flex list-none justify-center w-full"}
      (foreach
	[g (hoenn-gym-list)]
	[:li {:class "flex w-full justify-center"} (card g :g)])]]]
   ])
