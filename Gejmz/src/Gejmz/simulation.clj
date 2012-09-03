(ns Gejmz.simulation)

(defn create-dot [x y]
	{:x x :y y})
	
(defn move-dot-right [dot speed]
	(assoc dot :x (+ (:x dot) speed)))
	
(defn move-dot-down [dot speed]
	(assoc dot :y (+ (:y dot) speed)))
	
(defn move-dot-left [dot speed]
	(assoc dot :x (- (:x dot) speed)))

(defn move-dot-up [dot speed]
	(assoc dot :y (- (:y dot) speed)))

(defn move-dot-compound [dot]
	(-> dot ((fn [dot] (move-dot-right dot 10)))))
	
(defn dot-bounds [dot w h]
	(let [x (:x dot)
	      y (:y dot)
	      m 10]
		(cond 
			(> x w) (assoc dot :x (- m))
			(< x (- m)) (assoc dot :x w)
			(> y h) (assoc dot :y (- m))
			(< y (- m)) (assoc dot :y h)
			:else dot)))

(defn create-sim [dot-count w h]
	(into [] (repeatedly dot-count #(create-dot (rand w) (rand h)))))
	
(defn tick-sim [simulation]
	(for [dot simulation]
		(move-dot-compound dot)))
		
(defn check-bounds [simulation w h]
	(for [dot simulation]
		(dot-bounds dot w h)))
		
; (let [s (create-sim 1 100 100)]
; 	(prn "before:" s)
; 	(prn "after:" (check-bounds (tick-sim s) 100 100)))

; (let [d (create-dot 0 0)]
; 	(move-dot-compound d))