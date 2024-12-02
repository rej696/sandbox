(ns journal)

(require '[babashka.fs :as fs])
(require '[babashka.cli :as cli])
(require '[babashka.process :as bp])
(require '[clojure.edn :as edn])

(def ENTRIES-LOCATION "entries.edn")

(defn read-entries
  []
  (if (fs/exists? ENTRIES-LOCATION)
    (edn/read-string (slurp ENTRIES-LOCATION))
    []))

(defn add-entry
  [opts]
  (let [entries (read-entries)]
    (spit ENTRIES-LOCATION
          (conj entries
                (merge {:timestamp (System/currentTimeMillis)}
                       opts)))))

(defn list-entries
  [_]
  (let [entries (read-entries)]
    (doseq [{:keys [timestamp entry]} (reverse entries)]
      (println timestamp)
      (println entry "\n"))))

(def cli-opts
  {:entry {:alias :e
           :desc "Your dreams."
           :require true}
   :timestamp {:alias :t
               :desc "A unix timestamp, when you recorded this."
               :coerce {:timestamp :long}}})

(defn help
  [_]
  (doseq [e [(str "add\n"
                  (cli/format-opts {:spec cli-opts}))
             (str "list\n")]]
    (println e)))
  ; (dorun
  ;  (map println
  ;   [(str "add\n"
  ;         (cli/format-opts {:spec cli-opts}))
  ;    (str "list\n")])))


(def table
  [{:cmds ["add"] :fn add-entry :spec cli-opts}
   {:cmds ["list"] :fn list-entries :spec {}}
   {:cmds [] :fn help}])

; (cli/dispatch table *command-line-args*)

;(add-entry (first *command-line-args*))
;(cli/parse-opts ["-e" "The more I mowed, the higher the grass got :("] {:spec cli-opts})
