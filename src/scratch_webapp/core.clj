(ns scratch-webapp.core
  (:require [ring.adapter.jetty :as jetty]
            [hugsql.core :as hugsql]
            [clojure.tools.namespace.repl :refer [refresh]]))

(def db (System/getenv "DATABASE_URL"))
(def db "jdbc:postgresql://localhost/scratch_webapp")
(hugsql/def-db-fns "scratch_webapp/database.sql")
(hugsql/def-sqlvec-fns "scratch_webapp/database.sql")

(defn init-db
  []
  (install-uuid-module db)
  (create-endpoint-table db)
  (create-upload-table db)
  (create-row-table db)
  (create-cell-table db))


(defn reset-db!
  []
  (let [table-names (mapv :table_name (get-all-table-names db))]
    (for [table table-names]
      (doall
        (println (str "table name: " table " - table name type: " (type table)))
        (clear-table db {:table table})))))



(defn app
  [req]
  {:headers {}
   :status 200
   :body "Hello, World!"})

(defn -main
  []
  (init-db)
  (jetty/run-jetty app {:port 8080}))
