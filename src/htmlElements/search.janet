# This file will define the form used to search the database

# (def- sform-container :div.flex.bg-red-500.justify-center.mt-36)
# (def- sform :form.flex.justify-center.w-1/3.bg-blue-500)
# (def- sform-input-container :div.flex.bg-pink-500.w-full)
# (def- sform-input :input.flex-grow)
# (def- sform-button :button.bg-yellow-500)

(def- sform-container :div.flex.justify-center.items-center.w-full.mt-48.mb-4)
(def- sform :form.flex.justify-center.w-full.max-w-lg.p-4.rounded-lg)
(def- sform-input-container :div.flex.items-center.w-full)
(def- sform-input :input.flex-grow.w-full.px-4.py-2.rounded-l-md.border-2.border-grey-300.focus:border-red-500.focus:outline-none.focus:ring-2.focus:ring-white)
(def- sform-button :button.px-4.py-2.rounded-r-md.ml-2)


(def search-form
  [sform-container
   [sform {:class "bg-red-500"}
    [sform-input-container
     [sform-input {:class "" :type "text" :placeholder "Search..." :name "search"}]
     [sform-button {:class "bg-white border-2 border-red-500 border-solid hover:bg-red-500 hover:text-white hover:border-solid hover:border-2 hover:border-white"}"Search"]
     ]]])
