(ns scratch-webapp.core
  (:require [ring.adapter.jetty :as jetty]
            [hugsql.core :as hugsql]))


(hugsql/def-db-fns "scratch-webapp/db.sql")

(defn app
  [req]
  {:headers {}
   :status 200
   :body "Hello, World!"})

(defn -main 
  []
  (jetty/run-jetty app {:port 8080}))
