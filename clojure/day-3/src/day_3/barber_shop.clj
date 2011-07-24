(ns day-3.barber_shop)

(def haircuts (agent 0))
(def client (agent 0))
(def customers-in-shop (agent 0))

(defn make-haircut [h]
  (+ 1 h))

(defn customer-leaves-the-shop-with-a-haircut [c]
  (Thread/sleep 20)
  (send haircuts make-haircut)
  (if (> c 1)
      (send customers-in-shop customer-leaves-the-shop-with-a-haircut))
  (- c 1))

(defn customer-has-a-haircut [c]
  (send customers-in-shop customer-leaves-the-shop-with-a-haircut)
  (+ c 1))

(defn customer-waits-for-a-haircut [c]
  (+ c 1))

(defn customer-leaves-the-shop-without-a-haircut [c]
  c)

(defn customer-in-shop [c]
  (cond (= c 0) (customer-has-a-haircut c)
        (< c 3) (customer-waits-for-a-haircut c)
        (= c 3) (customer-leaves-the-shop-without-a-haircut c)))

(defn arrive [c]
  (Thread/sleep (+ 10 (rand-int 20)))
  (send customers-in-shop customer-in-shop)
  (send client arrive)
  c)

(defn how-many-customers-with-a-new-haircut-in [seconds]
  (send customers-in-shop #(* % 0))
  (send client arrive)
  (Thread/sleep (* 1000 seconds))
  @haircuts)
