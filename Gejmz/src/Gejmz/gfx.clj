(ns Gejmz.gfx
	(:use quil.core))
	
(defn pre-draw-dots [])
	
(defn draw-dot [x y]
	(fill (random 255) (+ 100 (random 55)) 150)
	(let [r (random 25 28)]
		(ellipse x y r r)))