(ns Closet.core
	(:use quil.core)
	(:gen-class))

(defn setup []
	(frame-rate 30))
	
(defn wave [f min max rate]
	"Generates a value that pulsates between min and max, using function f"
	(let [height (- max min)
		  half (/ height 2.0)
		  mid (+ min half)
		  t (/ (millis) 1000.0)]
		(+ mid (* half (f (* t rate))))))
		
(defn square [x]
	"Generates a square wave"
	(if (pos? (sin x)) 1.0 -1.0))
	
(defn color-func [x y]
	"Returns an array with three values: [R, G, B]"
	(if (or (and (odd? x) (even? y)) (and (even? x) (odd? y)))
		[(wave sin 100 255 3), (wave sin 100 255 4), (random 255)]
		[(wave sin 100 255 5), (wave sin 100 255 6), (wave sin 100 255 7)]))

(defn draw []
	(no-stroke)
	(let [step (wave sin 5 20 2.0) ;(inc (mouse-x))
		  x-steps (/ (width) step)
		  y-steps (/ (height) step)
		  cords (for [x (range x-steps) y (range y-steps)] [x y])]
		  	(doseq [[x y] cords]
				(apply fill (color-func x y))
				(rect (* x step) (* y step) step step))))
				
(defn on-key []
	(println "KEY:" (key-code))
	(fill 255 0 0))
	
(defsketch example                
	:title "SQUARES!"
	:setup setup           
	:draw draw  
	:key-pressed on-key          
	:size [400 300])
	
(defn -main []
	(println "Starting..."))