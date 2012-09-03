(ns Gejmz.utils
	(:use quil.core))

(defn wave 
	"Generates a value that pulsates between min and max, using function f"
	[f min max rate]
	(let [height (- max min)
		  half (/ height 2.0)
		  mid (+ min half)
		  t (/ (millis) 1000.0)]
		(+ mid (* half (f (* t rate))))))

(defn mesm 
	"Returns the coords/dimension for a moving rectangle"
	[] 
	(let [x (wave sin 0 (width) 1)
   		  y (/ (height) 2)]
				[x y 20 20]))