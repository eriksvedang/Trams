(ns Closet.core
	(:use quil.core)
	(:gen-class))

(defn setup []
	(no-stroke)
	(frame-rate 30))
	
(defn wave 
	"Generates a value that pulsates between min and max at a set rate, using function f"
	[f min max rate]
	(let [height (- max min)
		  half (/ height 2.0)
		  mid (+ min half)
		  t (/ (millis) 1000.0)]
		  (+ mid (* half (f (* t rate))))))
		
(defn square 
	"Generates a square wave"
	[x]	
	(if (pos? (sin x)) 1.0 -1.0))
	
(defn color-func 
	"Returns an array with three values: [R, G, B]"
	[x y]
	(if (or (and (odd? x) (even? y)) (and (even? x) (odd? y)))
		[(wave sin 100 255 3), (wave sin 100 255 4), (random 255)]
		[(wave sin 100 255 5), (wave sin 100 255 6), (wave sin 100 255 7)]))

(defn draw []
	(let [step (wave sin 5 20 2.0)
		  x-steps (/ (width) step)
		  y-steps (/ (height) step)
		  cords (for [x (range x-steps) y (range y-steps)] [x y])]
		  	(doseq [[x y] cords]
				(apply fill (color-func x y))
				(rect (* x step) (* y step) step step))))

(defsketch example                
	:title "SQUARES!"
	:setup setup
	:draw draw         
	:size [400 300])

(defn -main []
	(println "Starting..."))