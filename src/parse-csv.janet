(use ./structs/pokemon)
(use ./structs/gym)
# parse through a csv file of pokemon data
# retuens a list of pokemon structs.

(defn parse-pokemon [path]
  (let [f (file/open path)
	pokelist @[]]
    (while true                      
      (let [l (file/read f :line)]
	(when (not l)
	  (break))
	(var data (string/split "," l))
	(var id (get data 0))
	(var name (get data 1))
	(var region (get data 2))
	(var type1 (get data 3))
	(var type2 (get data 4))
	(var image (get data 5))
	(var pokemon (create-pokemon id name region [type1 type2] image))
	(array/push pokelist pokemon)))                
    (file/close f)
    pokelist))   


(defn parse-gyms [path]
    (let [f (file/open path)
	  gymlist @[]]
      (while true                      
	(let [l (file/read f :line)]
	  (pp l)
	  (when (not l)
	    (break))
	  (var data (string/split "," (string/trim l "\n")))
	  (var name (get data 0))
	  (var region (get data 1))
	  (var badge (get data 2))
	  (var tpy (get data 3))
	  (var image (get data 4))
	  (array/push gymlist gym)))                
      (file/close f)
      gymlist))   

