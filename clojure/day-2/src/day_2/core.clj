(ns day-2.core)
(defmacro unless [test body else-body]
  (list 'if (list 'not test) body else-body))

(defprotocol DoNotLikeProtocols
  (rant [d]))
(defrecord Troll []
  DoNotLikeProtocols
  (rant [_] "Why?"))
(defn troll [] (Troll.))
