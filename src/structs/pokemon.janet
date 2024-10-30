(use joy)

# This is a werid example of OOP in a lisp language
(def pokemon
  {# These are the attributes
   :number nil
   :name ""
   :region ""
   :typ []
   :image ""
   # These are the methods
   # here the key act as the def in defn so we can simply give it a function
   :list-types
   (fn [self]
     (foreach [t (self :typ)] [:li {:class ""} t]))
   })

(defn create-pokemon [number name region typs image]
  (struct/with-proto
    pokemon
    :number number
    :name name
    :region region
    :typ typs
    :image image))


