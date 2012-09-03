(ns Snurrigt.core)

; READ EVAL PRINT

(defn my-read 
	"Takes a string 's' and returns a list-structure in array form"
	[s]
	[s])
	
(defn function-for-operator-symbol
	"Returns a function, depending on symbol sent in"
	[sym]
	(let [table { 
			:plus +,
			:minus -,
			:divide /,
			:multiply * }]
		(sym table)))

(defn my-eval 
	"Takes a list structure 'e' and evaluates it"
	[e]
	; numbers are just returned, lists are evaluated
	(if (number? e)
		e
		(let [f (function-for-operator-symbol (first e))]
			(if (nil? f) 
				(println "Couldn't understand symbol" (first e) "\n")
				(let [args (rest e)]
					;(prn "f:" f "args:" args)
					(apply f (map my-eval args)))))))
	


;; Trying it out:

;(my-eval [:plus 4 [:multiply 3 [:divide 10 2]]])
