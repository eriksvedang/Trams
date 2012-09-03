(ns Gejmz.core
	(:use quil.core)
	(:use Gejmz.utils)
	(:use Gejmz.simulation)
	(:use Gejmz.gfx)
	(:gen-class))

(def w 600)
(def h 400)
(def simulation (ref (create-sim 100 w h)))
 
(defn loop-sim []
	(for [item @simulation] item))

(defn setup []
	(no-stroke)
	(frame-rate 30))

(defn draw []
	(background 0)
	(dosync
		(alter simulation tick-sim)
		(alter simulation check-bounds (width) (height)))
	(pre-draw-dots)
	(doseq [{x :x y :y} (loop-sim)]
		(draw-dot x y)))
				
(defn on-key [])
	
(defsketch example                
	:title "GEJMZ!"
	:setup setup           
	:draw draw  
	:key-pressed on-key          
	:size [w h])
	
; (defn -main []
; 	(println "Starting..."))