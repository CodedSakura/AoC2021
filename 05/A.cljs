(ns A
  (:require [clojure.string :as str])
  (:gen-class))
(use 'clojure.java.io)

(def data
  (map #(map (fn [x] (map read-string (str/split x #","))) (str/split % #" -> ")) (str/split-lines (slurp "input.txt"))))

(def gridSize
  [(inc (apply max (flatten (map #(map first %) data))))
  (inc (apply max (flatten (map #(map second %) data))))])

(def grid
  (vec (repeat (second gridSize) (vec (repeat (first gridSize) 0)))))

(doseq [d data]
  (def x1 (first (first d)))
  (def x2 (first (second d)))
  (def y1 (second (first d)))
  (def y2 (second (second d)))
  (cond
    (= y1 y2) (doseq [x (if (> x2 x1) (range x1 (inc x2)) (range x2 (inc x1)))] (def grid (update-in grid [y1 x] inc)))
    (= x1 x2) (doseq [y (if (> y2 y1) (range y1 (inc y2)) (range y2 (inc y1)))] (def grid (update-in grid [y x1] inc)))
    ))
(println (count (filter #(>= % 2) (flatten grid))))
