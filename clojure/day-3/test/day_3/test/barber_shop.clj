(ns day-3.test.barber_shop
  (:use [day-3.barber_shop] :reload)
  (:use [clojure.test]))

(deftest at-least-one-haircut-in-51-ms
  (is (> 500 (how-many-customers-with-a-new-haircut-in 10))))
