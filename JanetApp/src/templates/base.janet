# this is the base layout of the page.
# This should only hold the thing that EVERY page will use.
# This includes things like the doc type and other kinds of meta data.
(use joy)

# This defines an html template as a function.
(defn app-layout [{:body body :request request}]
  # Use the text/html fucntion to define a list of html elements.
  (text/html
    # Define the document type
    (doctype :html5)
    [:html {:lang "en"}
     [:head
      # Place all the meta data in the head
      [:title "Pokedex"]
      [:meta {:charset "utf-8"}]
      [:meta {:name "viewport" :content "width=device-width, initial-scale=1"}]
      [:meta {:name "csrf-token" :content (csrf-token-value request)}]
      [:link {:href "css/app.css" :rel "stylesheet"}]
      # cdn for the flowbite css 
      [:link {:href "https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css"}]
      [:script {:src "app.js" :defer ""}]]
     # Place any elements shared by all pages in the body tag
     [:body body
      # cdn for flowbite requried as the node_modules is not serverd by the server
      [:script {:src "https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"}]]]))
