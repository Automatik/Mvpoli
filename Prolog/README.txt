                                               		                                                                                                
                                                                                          

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RICHIESTE PROGETTO;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                	      

									                      
	Una delle prime e più importanti applicazioni dei calcolatori fu la                  
	manipolazione simbolica di operazioni matematiche. In particolare,                    
	i sistemi noti come Computer Algebra Systems 			                      
	(cfr., Mathematica, Maple, Maxima, Axiom, etc.)                                       
	si preoccupano di fornire funzionalita' per la manipolazione                          
	di polinomi multivariati.                                                             
	Lo scopo di questo progetto è la costruzione di una libreria                        
	(in Prolog) per la manipolazione di polinomi multivariati.                                                             
                                                                                             
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PREDICATI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;					     	      ;

	Nome: coefficients								      
	Sintassi: coefficients(Poly, Coefficients)					      
	Dettagli: Il predicato coefficients è vero quando Coefficients è una                
	          lista dei coeffcienti di Poly.                                              
	Esempio:                                                                              
	coefficinets(2*a+3*b, Coefficients).                                                  
	Coefficients = [2, 3]                                                               
	                                                                                       
        oppure
		  
     	coefficients(poly([m(2, 1, [v(1, a)]), m(3, 1, [v(1, b)])]), Coefficients)
        Coefficients = [2, 3]
-----------------------------------------------------------------------------------------------
	Nome: variables
	Sintassi: variables(Poly, Variables)
	Dettagli: Il predicato variables è vero quando Variables è una lista 
	dei simboli di variabile che appaiono in Poly.
	Esempio:
	variables(2*a+3*b, Variables).
	Variables = [a, b]
		
	oppure
		  
     variables(poly([m(2, 1, [v(1, a)]), m(3, 1, [v(1, b)])]), Variables)
        Variables = [a, b]
------------------------------------------------------------------------------------------------
	Nome: monomials
	Sintassi: monomials(Poly, monomials)
	Dettagli: Il predicato monomials è vero quando Monomials è 
	la lista ordinata (per grado crescente e in caso hanno lo stesso grado verranno 
	ordinati in maniera lessico-grafica),
	dei monomi che appaiono in Poly.
	
	Esempio:
	monomials(3*b+2*a+3*a*b*c, Monomials).
 	Monomials = [m(2, 1, [v(1, a)]), m(3, 1, [v(1, b)]), m(3, 3, [v(1, a), v(1, b), v(1, c)])]
		
	oppure
		  
     	monomials(poly([m(3, 1, [v(1, b)]), m(2, 1, [v(1, a)]), 
			m(3, 3, [v(1, a), v(1, b), v(1, c)]), Coefficients)
        Monomials = [m(2, 1, [v(1, a)]), m(3, 1, [v(1, b)]), m(3, 3, [v(1, a), v(1, b), v(1, c)])]
------------------------------------------------------------------------------------------------
	Nome: maxdegree
	Sintassi: maxdegree(Poly, Degree)
	Dettagli: Il predicato maxdegree è vero quando Degree è il massimo grado 
	dei monomi che appaiono in Poly.
	Esempio:
	maxdegree(2*a+3*b^2, Degree).
	Degree=2
		
	oppure
		  
     	maxdegree(poly([m(2, 1, [v(1, a)]), m(3, 1, [v(2, b)])]), Degree)
        Degree = 2
------------------------------------------------------------------------------------------------
	Nome: mindegree
	Sintassi: mindegree(Poly, Degree)
	Dettagli: Il predicato mindegree è vero quando Degree è il minimo grado 
	dei monomi che appaiono in Poly.
	Esempio:
	mindegree(2*a+3*b^2, Degree).
	Degree = 1
		
	oppure
		  
     	mindegree(poly([m(2, 1, [v(1, a)]), m(3, 1, [v(2, b)])]), Degree)
        Degree = 1
------------------------------------------------------------------------------------------------
	Nome: polyplus
	Sintassi: polyplus(Poly1, Poly2, Result)
	Dettagli: Il predicato polyplus è vero quando Result
	è il polinomio somma di Poly1 e Poly2.
	Esempio:
	polyplus(2*a+3*b, a*b, Result).
	Result = poly([m(3, 1, [v(1, a)]), m(4, 1, [v(1, b)])])
		
	oppure
		  
     	polyplus(poly([m(2, 1, [v(1, a)]), m(3, 1, [v(1, b)])]), poly([m(1, 1, [v(1, a)]), 
		m(3, 1, [v(1, b)])]), Result).
	Result = poly([m(3, 1, [v(1, a)]), m(4, 1, [v(1, b)])])
------------------------------------------------------------------------------------------------
	Nome: polyminus
	Sintassi: polyminus(Poly1, Poly2, Result)
	Dettagli: Il predicato polyminus è vero quando Result
	è il polinomio differenza di Poly1 e Poly2.
	Esempio:
	polyminus(2*a+3*b, a*b, Result).
	Result = poly([m(1, 1, [v(1, a)]), m(2, 1, [v(1, b)])])
		
	oppure
		  
     	polyminus(poly([m(2, 1, [v(1, a)]), m(3, 1, [v(1, b)])]), poly([m(1, 1, [v(1, a)]), 
		m(3, 1, [v(1, b)])]), Result).
	Result = poly([m(1, 1, [v(1, a)]), m(2, 1, [v(1, b)])])
------------------------------------------------------------------------------------------------
	Nome: polytimes
	Sintassi: polytimes(Poly1, Poly2, Result)
	Dettagli: Il predicato polytimes è vero quando Result
	è il polinomio risultante dalla moltiplicazione di Poly1 e Poly2.
	Esempio:
	polytimes(2*a+3*b, a*b, Result).
	Result = poly([m(5, 2, [v(1, a), v(1, b)]), m(2, 2, [v(2, a)]), m(3, 2, [v(2, b)])])
		
	oppure
		  
     	polytimes(poly([m(2, 1, [v(1, a)]), m(3, 1, [v(1, b)])]), poly([m(1, 1, [v(1, a)]),
			 m(3, 1, [v(1, b)])]), Result).
	Result = poly([m(5, 2, [v(1, a), v(1, b)]), m(2, 2, [v(2, a)]), m(3, 2, [v(2, b)])])
------------------------------------------------------------------------------------------------
	Nome: as_monomial
	Sintassi: as_monomial(Expression, Monomial)
	Dettagli: Il predicato as_monomial è vero quando Monomial è il termine 
	che rappresenta il monomio risultante dal "parsing" dell'espressione 
	Expression; il monomio risultante viene appropriatamente ordinato.
	Esempio:
	as_monomial(2*b^2*a, Monomial).
	Monomial = m(2, 3, [v(1, a), v(2, b)])
		
------------------------------------------------------------------------------------------------
	Nome: as_polynomial
	Sintassi: as_polynomial(Expression, Polynomial)
	Dettagli: Il predicato as_polynomial è vero quando Polynomial è il termine 
	che rappresenta il polinomio risultante dal "parsing" dell'espressione 
	Expression; il polinomio risultante viene appropriatamente ordinato.
	Esempio:
	as_polynomial(2*b^2*a+a*b, Polynomial).
	Polynomial = poly([m(1, 2, [v(1, a), v(1, b)]), m(2, 3, [v(1, a), v(2, b)])])
------------------------------------------------------------------------------------------------
	Nome: polyval
	Sintassi: polyval(Polynomial, VariableValues, Value)
	Dettagli: Il predicato polyval è vero quanto Value contiene il valore 
   	del polinomio Polynomial (che può anche essere un monomio), 
	nel punto n-dimensionale rappresentato dalla lista VariableValues, 
	che contiene un valore per ogni variabile ottenuta con il predicato variables/2.
	Esempio:
	polyval(2*a+3*b, [4, 5], Value)
	Value=23
		
	oppure
		  
     	polyval(poly([m(2, 1, [v(1, a)]), m(3, 1, [v(1, b)])]), Value)
        Value=23
------------------------------------------------------------------------------------------------
	Nome: pprint_polynomial
	Sintassi: pprint_polynomial(Polynomial)
	Dettagli: Il predicato pprint polynomial risulta vero dopo aver stampato 
	(sullo "standard output") una rappresentazione tradizionale del termine polinomio associato 
	a Polynomial
	Esempio:
	pprint_polynomial(poly([m(2, 1, [v(1, a)]), m(3, 1, [v(1, b)])])).
	+2*a+3*b
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;