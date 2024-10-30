(use joy)
(use ./templates/base)
(use ./routes)

# This creates the app and defines all the middleware.
# If you are unsure on what middleware is then dont mess with this list
# but simply it is a bunch of functions and other things that the app uses to preform tasks
(def app (-> (handler)
             (layout app-layout)
             (with-csrf-token)
             (with-session)
             (extra-methods)
             (query-string)
             (body-parser)
             (json-body-parser)
             (server-error)
             (x-headers)
             (static-files)
             (not-found)
             (logger)))

# This is the entry point of the application.
# This is a simple server setup. but will work for the demo
(defn main [& args]
  (db/connect (env :database-url))
  (server app (env :port))
  (db/disconnect))
