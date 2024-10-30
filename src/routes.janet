# This file can be used to define and implement the routes the app will handle.
# The main options are the classic definition of routes and with a seperate implementation
# the other option is having the routes as decerators which keeps the routes next to its implementation.
# CURRENT STYLE: decerators
(use joy)
(use ./templates/homepage)
(use ./templates/gympage)
(use ./testdata)
(use ./parse-csv)

# This is the decorator style for defining routes
# call route define which method (get, post, etc)
# define the path of the route
# and the function that will handle the request
# Below the route define the function you put in the route call
(var pokelist (array/concat (parse-pokemon "./csvdata/gen1_pokemon.csv") (parse-pokemon "./csvdata/gen2_pokemon.csv")))

(route :get "/" :home)
(defn home [request]
  # The mainpage is a function that defines the html
  (mainpage pokelist))

(route :get "/gyms" :gyms)
(defn gyms [request]
  (gympage))
  


