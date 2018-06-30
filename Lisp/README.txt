                                             		      
                                                                                          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RICHIESTE PROGETTO;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                	      

									                      
	Una delle prime e più importanti applicazioni dei calcolatori fu la                  
	manipolazione simbolica di operazioni matematiche. In particolare,                    
	i sistemi noti come Computer Algebra Systems 			                      
	(cfr., Mathematica, Maple, Maxima, Axiom, etc.)                                       
	si preoccupano di fornire funzionalita' per la manipolazione                          
	di polinomi multivariati.                                                             
	Lo scopo di questo progetto è la costruzione di una libreria                        
	(in Common lisp) per la manipolazione di polinomi multivariati.                                                             
                                                                                             
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FUNZIONI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;					     	      

	Nome: coefficients								      
	Sintassi: coefficients Poly -> Coefficients					      
	Dettagli: La funzione coefficients ritorna una lista 
	Coefficients dei coefficienti di Poly.                                              
	Esempio:                                                                              
	(coefficients '(+ (* 2 A) (* 3 B)))                                                  
	(2, 3)                                                              
	                                                                                       
        oppure
		  
     	(coefficients '(POLY ((M 2 1 ((V 1 A))) (M 3 1 ((V 1 B)))))
        (2, 3)
-----------------------------------------------------------------------------------------------
	Nome: variables
	Sintassi: variables Poly -> Variables
	Dettagli: La funzione variables ritorna una lista Variables dei simboli di variabile 
	che appaiono in Poly.
	Esempio:
	(variables '(+ (* 2 A) (* 3 B)))
	(A B)
		
	oppure
		  
     	(variables '(POLY ((M 2 1 ((V 1 A))) (M 3 1 ((V 1 B)))))
	(A B)
------------------------------------------------------------------------------------------------
	Nome: monomials
	Sintassi: monomials Poly -> monomials
	Dettagli: La funzione monomials ritorna	la lista ordinata 
	(per grado crescente e in caso hanno lo stesso grado verranno 
	ordinati in maniera lessico-grafica),
	dei monomi che appaiono in Poly.
	
	Esempio:
	(monomials '(+ (* 3 B) (* 2 A) (* 3 A B C)))
 	((M 2 1 ((V 1 A))) (M 3 1 ((V 1 B))) (M 3 3 ((V 1 A) (V 1 B) (V 1 C))))
		
	oppure
		  
     	(monomials '(POLY ((M 3 1 ((V 1 B))) (M 2 1 ((V 1 A))) (M 3 3 ((V 1 A) (V 1 B) (V 1 C))))))
        ((M 2 1 ((V 1 A))) (M 3 1 ((V 1 B))) (M 3 3 ((V 1 A) (V 1 B) (V 1 C))))
------------------------------------------------------------------------------------------------
	Nome: maxdegree
	Sintassi: maxdegree Poly -> Degree
	Dettagli: La funzione maxdegree ritorna il massimo grado 
	dei monomi che appaiono in Poly.
	Esempio:
	(maxdegree '(+ (* 2 A) (* 3 (EXPT B 2))))
	2
		
	oppure
		  
     	(maxdegree '(POLY ((M 2 1 ((V 1 A))) (M 3 1 ((V 1 B)))))
        2
------------------------------------------------------------------------------------------------
	Nome: maxdegree
	Sintassi: maxdegree Poly -> Degree
	Dettagli: La funzione mindegree ritorna il minimo grado 
	dei monomi che appaiono in Poly.
	Esempio:
	(mindegree '(+ (* 2 A) (* 3 (EXPT B 2))))
	1
		
	oppure
		  
     	(mindegree '(POLY ((M 2 1 ((V 1 A))) (M 3 1 ((V 1 B)))))
        1
------------------------------------------------------------------------------------------------
	Nome: polyplus
	Sintassi: polyplus Poly1 Poly2 -> Result
	Dettagli: La funzione polyplus ritorna 
	il polinomio somma di Poly1 e Poly2.
	Esempio:
	(polyplus '(+ (* 2 A) (* 3 B)) '(+  A B))
	(POLY ((M 3 1 ((V 1 A))) (M 4 1 ((V 1 B)))))
		
	oppure
		  
     	(polyplus '(POLY ((M 2 1 ((V 1 A))) (M 3 1 ((V 1 B)))) '(POLY ((M 1 1 ((V 1 A))) (M 1 1 ((V 1 B)))))
	(POLY ((M 3 1 ((V 1 A))) (M 4 1 ((V 1 B)))))
------------------------------------------------------------------------------------------------
	Nome: polyminus
	Sintassi: polyminus Poly1 Poly2 -> Result
	Dettagli: La funzione polyminus ritorna 
	il polinomio differenza di Poly1 e Poly2.
	Esempio:
	(polyminus '(+ (* 2 A) (* 3 B)) '(+  A B))
	(POLY ((M 1 1 ((V 1 A))) (M 2 1 ((V 1 B)))))
		
	oppure
		  
     	(polyminus '(POLY ((M 2 1 ((V 1 A))) (M 3 1 ((V 1 B)))) '(POLY ((M 1 1 ((V 1 A))) (M 1 1 ((V 1 B)))))
	(POLY ((M 1 1 ((V 1 A))) (M 2 1 ((V 1 B)))))
------------------------------------------------------------------------------------------------
	Nome: polytimes
	Sintassi: polytimes Poly1 Poly2 -> Result
	Dettagli: La funzione polytimes ritorna il polinomio risultante dalla moltiplicazione 
	di Poly1 e Poly2.
	Esempio:
	(polytimes '(+ (* 2 A) (* 3 B)) '(+  A B))
	(POLY ((M 5 2 ((V 1 A) (V 1 B))) (M 2 2 ((V 2 A))) (M 3 2 ((V 2 B)))))
		
	oppure
		  
     	(polytimes '(POLY ((M 2 1 ((V 1 A))) (M 3 1 ((V 1 B)))) '(POLY ((M 1 1 ((V 1 A))) (M 1 1 ((V 1 B)))))
	(POLY ((M 5 2 ((V 1 A) (V 1 B))) (M 2 2 ((V 2 A))) (M 3 2 ((V 2 B)))))
------------------------------------------------------------------------------------------------
	Nome: as_monomial
	Sintassi: as_monomial Expression -> Monomial
	Dettagli: La funzione as_monomial ritorna il termine 
	che rappresenta il monomio risultante dal "parsing" dell'espressione 
	Expression; il monomio risultante viene appropriatamente ordinato.
	Esempio:
	(as-monomial '(* 3 A (EXPT B 2)))
	(M 3 3 ((V 1 A) (V 2 B)))
		
------------------------------------------------------------------------------------------------
	Nome: as_polynomial
	Sintassi: as_polynomial Expression -> Polynomial
	Dettagli: La funzione as_polynomial ritorna il termine 
	che rappresenta il polinomio risultante dal "parsing" dell'espressione 
	Expression; il polinomio risultante viene appropriatamente ordinato.
	Esempio:
	as_polynomial(2*b^2*a+a*b, Polynomial).
	(as-polynomial '(+ (* 2 (EXPT B 2) A) (* A B)))
	(POLY ((M 1 2 ((V 1 A) (V 1 B))) (M 2 3 ((V 1 A) (V 2 B)))))
------------------------------------------------------------------------------------------------
	Nome: polyval
	Sintassi: polyval Polynomial VariableValues -> Value
	Dettagli: La funzione polyval ritorna il valore 
   	del polinomio Polynomial (che può anche essere un monomio), 
	nel punto n-dimensionale rappresentato dalla lista VariableValues, 
	che contiene un valore per ogni variabile ottenuta con La funzione variables/2.
	Esempio:
	(polyval '(+ (* 2 A) (* 3 B)) '(4 5))
	23
		
	oppure
		  
     	(polyval '(POLY ((M 2 1 ((V 1 A))) (M 3 1 ((V 1 B)))) '(4 5))
        23
------------------------------------------------------------------------------------------------
	Nome: pprint_polynomial
	Sintassi: pprint_polynomial Polynomial -> NIL
	Dettagli: La funzione pprint polynomial ritorna NIL dopo aver stampato 
	(sullo "standard output") una rappresentazione tradizionale del termine polinomio associato 
	a Polynomial
	Esempio:
	(pprint_polynomial '(POLY ((M 2 1 ((V 1 A))) (M 3 1 ((V 1 B)))))
	"+2 a +3 b"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;