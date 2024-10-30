(use joy)

(def gym
  {:name ""
   :region ""
   :leader []
   :badge ""
   :typ ""
   :list-leader
   (fn [self]
     (foreach [l (self :leader) [:li {:class ""} l]]))
   })

(defn create-gym [name region leaders badge typ]
  (struct/with-proto
    gym
    :name name
    :region region
    :leader leaders
    :badge badge
    :type type))

