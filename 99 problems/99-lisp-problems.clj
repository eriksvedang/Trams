; P01 (*) Find the last box of a list.

(defn my-last [[x & xs]]
  (if (empty? xs)
    x
    (recur xs)))


; P02 (*) Find the last but one box of a list.

(defn sec-last [[x1 x2 & xs]]
  (if (nil? xs)
    x1
    (recur (cons x2 xs))))


; P03 (*) Find the K'th element of a list.

(defn kth [xs k]
  (loop [i 1 l xs]
    (if (= i k)
      (first l)
      (recur (inc i) (rest l)))))


; P04 (*) Find the number of elements of a list.

(defn num-elem [coll]
  (loop [n 0 xs coll]
    (if (empty? xs)
      n
      (recur (inc n) (rest xs)))))


; P05 (*) Reverse a list.

(defn my-reverse [coll]
  (if (empty? coll)
    []
    (conj (my-reverse (rest coll)) (first coll)))) ; Inte lazy!


; P06 (*) Find out whether a list is a palindrome.

(defn pali? [coll]
  (= (seq coll) (reverse coll)))


; P07 (**) Flatten a nested list structure.









