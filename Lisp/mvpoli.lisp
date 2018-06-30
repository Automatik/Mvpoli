;;;; -*- Mode: Lisp -*-

;; dato un monomio verifico che rispetti la scrittura
(defun is-monomial (m)
  (and (listp m) ;controllo che sia scritto nella forma corretta (m coeff td vars-powers)
       (eq 'm (first m)) ;controllo che ci sia la lettera M
       (numberp (parse-coefficient (second m)))
       (let ((mtd (third m))
             (vps (fourth m)))
         (and (integerp mtd)
              (>= mtd 0)
              (is-degree-correct mtd vps)
              (listp vps)
              (every #'is-varpower vps)))))

;; dato una variabile verifico che rispetti la scrittura
(defun is-varpower (vp)
  (and (listp vp)
       (eq 'v (first vp))
       (let ((power (second vp))
             (var (third vp)))
         (and (integerp power)
              (>= power 0)
              (every #'alpha-char-p (string var))))))

;; dato un polinomio verifico che rispetti la scrittura
(defun is-polynomial (p)
  (and (listp p)
       (eq 'poly (first p))
       (let ((ms (second p)))
         (and (listp ms)
              (every #'is-monomial ms)))))

;; restituisco la lista di variabili di un monomio
(defun varpowers (m)
  (if (null m)
      nil
    (if (is-monomial m)
        (fourth m)
      (fourth (as-monomial m)))))
;; restituisco i simboli di variabile di un monomio    
(defun vars-of (m)
  (if (null m)
      nil
    (if (is-monomial m)
        (let ((vps (varpowers m)))
          (if (null (every #'is-varpower vps))
              nil
            (var-symbols vps)))
      (vars-of (as-monomial m)))))

(defun var-symbols (vps)
  (if (null vps)
      nil
    (flatten (list (third (first vps)) (var-symbols (rest vps))))))

; manca in lispworks
(defun flatten (l)
  (if l
      (if (atom l) 
          (list l) 
        (mapcan #'flatten l))))


#|(defun flatten (x)
  (cond ((null x) x)
        ((atom x) (list x))
        (T (append (flatten (first x))
                   (flatten (rest x)))))) |#

(defun is-degree-correct (mtd vps)
  (let ((td (if (null (every #'is-varpower vps))
                nil
              (sum-varpowers vps))))
    (if (= mtd td)
        T
      nil)))
;; restituisce il grado di un monomio
(defun monomial-degree (m)
  (if (null m)
      0
    (cond ((is-monomial m) (third m))
          (T (monomial-degree (as-monomial m))))))

(defun sum-varpowers (vps)
  (if (null vps)
      0
    (+ (second (first vps)) (sum-varpowers (rest vps)))))
;;restituisce il coefficiente di un monomio
(defun monomial-coefficient (m)
  (if (null m)
      0
    (cond ((is-monomial m) (second m))
          (T (monomial-coefficient (as-monomial m))))))
;; restituisce la lista di coefficienti di un polinomio
(defun coefficients (p)
  (if (null p)
      nil
    (if (null (is-polynomial p))
        (coefficients (as-polynomial p))
      (let ((ms (second p)))
        (mapcar 'monomial-coefficient ms)))))
;;restituisce la lista di variabili di un polinomio
(defun variables (p)
  (if (null p)
      nil
    (if (null (is-polynomial p))
        (variables (as-polynomial p))
      (let ((ms (second p)))
        (sort (remove-duplicates (flatten (mapcar 'vars-of ms))) #'string-lessp)))))
;;restituisce il grado massimo di un polinomio
(defun maxdegree (p)
  (cond ((null p) nil)
        ((and (listp p)
              (null (second p))) 0)
        (T (if (null (is-polynomial p))
               (maxdegree (as-polynomial p))
             (let ((ms (second p)))
               (apply 'max (mapcar 'monomial-degree ms)))))))
;;restituisce il grado minimo di un polinomio
(defun mindegree (p)
  (cond ((null p) nil)
        ((and (listp p)
              (null (second p))) 0)
        (T (if (null (is-polynomial p))
               (mindegree (as-polynomial p))
             (let ((ms (second p)))
               (apply 'min (mapcar 'monomial-degree ms)))))))

;restituisce il monomio dato parsato
(defun as-monomial (m)
  (if (or (null (listp m))
          (eq 'expt (first m))
          (numberp (ignore-errors (eval m))))
      (add-zero (car (remove-zeros (list (add-m (as-mony m))))))
    (let ((coeff (parse-coefficient (car (cdr m))))
          (vars (mapcar 'as-mony (cdr (cdr m)))))
      (if (and (not (null coeff)) ;se coeff non nullo e lista inizia con operatore *
               (eq '* (first m)))
          (if (null (numberp coeff)) ;se il coeff � una variabile
              (if (null (cdr (cdr m))) ;se non c'� qualcosa dopo il coeff(var) nella lista
                  (car (monomials (list 'poly
                                       
 (compress (monomials (list 'poly
                                                                   
(list  (list 'm 
                                                                                
1 
                                                                                
(sum-varpowers (list (as-mony coeff))) 
                                                                                
(list (as-mony coeff)))))))))) 
                (if (null (member nil vars)) 
;se vars non contiene nessuna variabile scritta male(cio� valore NIL)
                    (add-zero (car (monomials (list 'poly
                                                    
(compress (monomials (list 'poly
                                                                               
(list (list 'm
                                                                                           
1
                                                                                           
(sum-varpowers (append (list (as-mony coeff)) vars)) ;
                                                                                           
(append (list (as-mony coeff)) vars))))))))))
                  nil))
            (if (null (cdr (cdr m))) 
;se non c'� qualcosa dopo il coeff(num) nella lista
                (list 'm coeff 0 nil) 
              (if (null (member nil vars)) 
;se vars non contiene nessuna variabile scritta male(cio� valore NIL)
                  (add-zero (car (monomials (list 'poly
                                                  
(compress (monomials (list 'poly
                                                                             
(list (list 'm
                                                                                         
coeff
                                                                                         
(sum-varpowers vars) 
                                                                                         
vars)))))))))
                nil)))
        nil))))
          
(defun as-mony (m)
  (cond ((numberp (parse-coefficient m)) (parse-coefficient m)) ;`('m 0 nil)
        ((and (null (listp m))
              (every #'alpha-char-p (string m))) `(v 1 ,m))
        ((and (listp m)
              (eq 'expt (first m))) 
         (let ((var (second m))                                     
               (exp (third m)))         
           (if (or (null (integerp exp))                              
(null (every #'alpha-char-p (string var))))
                                          nil
                                        `(v ,exp ,var))))))

(defun add-m (m)
  (cond ((numberp m) (list 'm  m 0 nil)) ;se m � un numero
        ((and (listp m)              ;se m � una variabile
              (eq 'v (first m)))
         (list 'm 1 (second m) (list m)))))

(defun add-zero (m)
  (if (null m)
      '(m 0 0 nil)
    m))

;mi serve per calcolare coefficienti come (cos 30) altrimenti lascia c cos� com'�
(defun parse-coefficient (c)
  (if (and (listp c)
           (null (eq 'expt (first c))))
      (ignore-errors (eval c))
    c))
;;restituisce il polinomio dato parsato
(defun as-polynomial (p)
  (let ((poly (cond ((null (listp p)) 
                     (list 'poly (list (as-monomial p))))
                    ((and (listp p)
                          (or (eq 'expt (first p))
                              (eq '* (first p))))
                     (list 'poly (list (as-monomial p))))
                    ((or (eq '+ (first p))
                         (eq '- (first p)))
                     (let ((ms (cdr p)))
                       (list 'poly
                             (monomials 
                              (list 'poly                          
                         (compress (monomials (list 'poly                                                                       
                          (remove-sublist (mapcar 'as-monomial ms)                                                                                          
nil))))))))))))
    (if (equal '((m 0 0 nil)) (second poly))
        '(poly ())
      poly)))
;;restituisce la somma dei due polinomi    
(defun polyplus (p1 p2)
  (if (or (null p1)
          (null p2))
      nil
    (if (and (is-polynomial p1)
             (is-polynomial p2))
        (let ((ms1 (monomials p1))
              (ms2 (monomials p2)))
          (list 'poly 
                (monomials (list 'poly
                                 (compress (append ms1 
                                                   ms2))))))
      (polyplus (as-polynomial p1)
                (as-polynomial p2)))))
;; restituisce la differenza dei due polinomi
(defun polyminus (p1 p2)
  (if (or (null p1)
          (null p2))
      nil
    (if (and (is-polynomial p1)
             (is-polynomial p2))
        (let ((ms1 (monomials p1))
              (ms2 (monomials p2)))
          (list 'poly
                (monomials (list 'poly
                                 (compress (append ms1
                                                   
                                 (negate-monomials ms2)))))))
      (polyminus (as-polynomial p1)
                 (as-polynomial p2)))))
;;restituisce la moltiplicazione dei due polinomi
(defun polytimes (p1 p2)
  (if (or (null p1)
          (null p2))
      nil
    (if (and (is-polynomial p1)
             (is-polynomial p2))
        (list 'poly
              (monomials (list 'poly
                               (compress (monomials (list 'poly
                                                          
                        (multiplicate-polynomials (second p1)
                                                                                    
                                                  (second p2))))))))
      (polytimes (as-polynomial p1)
                 (as-polynomial p2)))))

(defun multiplicate-polynomials (ms1 ms2)
  (if (and (listp ms1)
           (listp ms2))
      (if (not (null ms2))
          (append (multiplicate-monomials ms1 (first ms2)) 
                  (multiplicate-polynomials ms1 (rest ms2)))
        nil)
    nil))

(defun multiplicate-monomials (ms m)
  (if (listp ms)
      (if (not (null ms))
          (append (list (list 'm
                              (* (monomial-coefficient (first ms)) 
                                 (monomial-coefficient m))
                              (+ (monomial-degree (first ms))
                                 (monomial-degree m))
                              (sum-variables (varpowers (first ms)) 
                                             (varpowers m))))
                  (multiplicate-monomials (rest ms) m))
        nil)
    nil))     

(defun sum-variables (vs1 vs2)
  (if (and (listp vs1)
           (listp vs2))
      (cond ((and (null vs1)
                  (null vs2))
             nil)
            ((and (null vs1)
                  (not (null vs2)))
             vs2)
            ((and (not (null vs1))
                  (null vs2))
             vs1)
            ((and (not (null vs1))
                 (not (null vs2)))
            (let ((vp1 (extract-variable (first vs1) vs1))
                  (vp2 (extract-variable (first vs1) vs2)))
              (append (list (list 'v
                                  (sum-varpowers (append vp1 vp2))
                                  (third (first vp1))))
                      (sum-variables (set-difference vs1 vp1 :test 'equal) 
                                     (set-difference vs2 vp2 :test 'equal))))))
    nil))

(defun extract-variable (v vs)
  (if (listp vs)
      (cond ((null vs) nil)
            ((and (not (null vs))
                  (eq (third v) (third (first vs))))
             (append (list (first vs)) (extract-variable v (rest vs))))
            (T (extract-variable v (rest vs))))
    nil))

(defun sum-lists (ms)
  (if (and (listp ms)
           (not (null ms)))
      (if (is-varpower (first (first ms)))
          (append (list (sum-powers (first ms))) (sum-lists (rest ms)))
        (append (list (sum-monomials (first ms))) (sum-lists (rest ms))))
    nil))

;questa a differenza di sum-varpowers ritorna una variabile con esponente 
;sommato alle variabili uguali
(defun sum-powers (vps)
  (if (listp vps)
      (if (not (null vps))
          (let ((p1 (second (first vps)))
                (v (third (first vps)))
                (var (sum-powers (rest vps))))
            (list 'v
                  (+ p1 (second var))
                  v))
        (list 'v 0 'v))
    nil))

(defun sum-monomials (ms)
  (if (listp ms)
      (if (not (null ms))
          (let ((m (first ms)))
            (list 'm
                  (+ (monomial-coefficient m)
                     (monomial-coefficient (sum-monomials (rest ms))))
                  (monomial-degree m)
                  (varpowers m)))
        (list 'm 0 0 nil))
    nil))

(defun compress (ms)
  (if (and (listp ms)
           (not (null ms)))
      (remove-zeros (sum-lists (dividi (compress-vars ms)
                                       '())))
    nil))

(defun remove-zeros (ms)
  (if (and (listp ms)
           (not (null ms)))
      (let ((m (first ms)))
        (cond ((eq 0 (monomial-coefficient m))
               (remove-zeros (rest ms)))
              ((eq 0 (monomial-degree m))
               (append (list (list 'm
                                   (monomial-coefficient m)
                                   0
                                   nil))
                       (remove-zeros (rest ms))))
              ((var-contain-zero (varpowers m))
               (append (list (list 'm
                                   (monomial-coefficient m)
                                   (monomial-degree m)
                                   (remove-var-zeros (varpowers m))))
                       (remove-zeros (rest ms))))
              (T (append (list m)
                         (remove-zeros (rest ms))))))
    nil))

(defun var-contain-zero (vs)
  (if (null vs)
      nil
    (if (eq 0 (second (first vs)))
        T
      (var-contain-zero (rest vs)))))

(defun remove-var-zeros (vs)
  (if (null vs)
      nil
    (if (eq 0 (second (first vs)))
        (remove-var-zeros (rest vs))
      (append (list (first vs))
              (remove-var-zeros (rest vs))))))

(defun compress-vars (ms)
  (cond ((and (listp ms)
              (not (is-monomial ms)))
         (if (not (null ms))
             (append (list (compress-vars (first ms)))
                     (compress-vars (rest ms)))
           nil))
        ((is-monomial ms)
         (list 'm
               (monomial-coefficient ms)
               (monomial-degree ms)
               (sum-lists (dividi (varpowers ms)
                            '()))))))

;chiamare dividi con l='()
(defun dividi (ms l)
  (if (listp ms)
      (if (not (null ms))
          (let ((m (first ms))
                (subl (presente (first ms) l)))
            (if (not (null subl)) ;base letterale di m gi� presente nella lista
                (dividi (rest ms)
                        (append (remove-sublist l subl)
                                (list (append subl (list m)))))
              (dividi (rest ms) ;aggiungo m con la sua base letterale alla lista
                      (append l (list (list m))))))
        l)
    nil))
              

(defun remove-sublist (l sublist)
  (if (and (listp l)
           (listp sublist)
           (not (null l)))
      (if (equal sublist (first l))
          (remove-sublist (rest l) sublist)
        (append (list (first l)) (remove-sublist (rest l) sublist)))
    nil))

;usata sia per i monomi interi che per le singoli variabili
(defun presente (m l)
  (if (and (listp l)
           (not (null l)))
      (cond ((is-monomial m) 
             (let ((sublist (first l)) 
;se il monomio � presente in una delle sottoliste
                                   (monomial (first (first l))))
                               
               (if (and (eq (monomial-degree m) 
                            (monomial-degree monomial))
                                        
                        (equal (varpowers m) (varpowers monomial)))
                                   sublist
                                 (presente m (rest l)))))
            ((is-varpower m) (let ((sublist (first l)) 
;se la variabile � presente in una delle sottoliste
                                   (var (first (first l))))
                               (if (eq (third var) (third m))
                                   sublist
                                 (presente m (rest l))))))
    nil))

(defun negate-monomials (ms)
  (if (and (listp ms)
           (not (null ms)))
      (let ((m (first ms))
            (coeff (monomial-coefficient (first ms))))
        (append (list (list 'm
                            (- coeff)
                            (monomial-degree m)
                            (varpowers m)))
                (negate-monomials (rest ms))))
    nil))

;sostituisce i valori nelle variabili e calcola il risultato
(defun polyval (p varvalues)
  (if (or (null p)
          (null varvalues))
      nil
    (if (and (is-polynomial p)
             (every #'realp varvalues))
        (let ((vars (variables p)))
          (calcola (sostituisci (second p) vars varvalues)))
      (polyval (as-polynomial p) varvalues))))

(defun sostituisci (ms vars varvalues)
  (if (and (listp ms)
           (listp vars)
           (listp varvalues))
      (if (not (null ms))
          (let ((vs (varpowers (first ms))))
            (append (list (append (remove-sublist (first ms) vs)
                            (list (cambia vs vars varvalues))))
                    (sostituisci (rest ms) vars varvalues)))
        nil)
    nil))

(defun cambia (vs vars varvalues)
  (if (and (listp vs)
           (listp vars)
           (listp varvalues))
      (if (not (null vs))
          (append (list (list 'v 
                              (second (first vs))
                              (nth (position (third (first vs)) vars)
                                   varvalues)))
                  (cambia (rest vs) vars varvalues))
        nil)
    nil))

(defun calcola (ms)
  (if (listp ms)
      (if (not (null ms))
          (+ (* (second (first ms))
                (calcola-vars (fourth (first ms))))
             (calcola (rest ms)))
        0)
    0))

(defun calcola-vars (vs)
  (if (listp vs)
      (if (not (null vs))
          (* (expt (third (first vs)) (second (first vs)))
             (calcola-vars (rest vs)))
        1)
    1))    
;restituisce il polinomio ordinato  
(defun monomials (p)
  (if (null p)
      nil
    (if (null (is-polynomial p))
        (monomials (as-polynomial p))
      (if (null (second p))
          nil
        (let ((p1 (ordina-stesso-grado 
                   (ordina-monomi (mergesort (second p))) (mindegree p))))
          (parse-polynomial p1))))))
  

(defun list-head (lst n) (if (eq n 0) '() 
                           (cons (car lst) (list-head (cdr lst) (- n 1)))))
(defun list-tail (lst n) (if (eq n 0) lst 
                           (list-tail (cdr lst) (- n 1))))

(defun _merge (lst-a lst-b)
  (cond ((not lst-a) lst-b)
        ((not lst-b) lst-a)
        ((< (monomial-degree (car lst-a)) 
            (monomial-degree (car lst-b))) 
         (cons (car lst-a) 
               (_merge (cdr lst-a) lst-b)))
        (T (cons (car lst-b) (_merge lst-a (cdr lst-b))))))

(defun mergesort (lst)
  (if (eq (length lst) 1)
    lst
    (_merge (mergesort (list-head lst (truncate (length lst) 2)))
            (mergesort (list-tail lst (truncate (length lst) 2))))))
 
;(defun ordina-monomi (p) 
  #|(if (null (second p))
      nil
  (append (list 'poly) (append ((first p) (second p) (third p) 
(mergesort2 (fourth (car (second p)))))  (ordina-monomi(second p))))))|#
(defun ordina-monomi (ms)
  (if (null ms)
      nil
    (let ((m (first ms))
          (vs (varpowers (first ms))))
      (append (list (append (remove-sublist m vs)
                      (list (mergesort2 vs))))
              (ordina-monomi (rest ms))))))


(defun _merge2 (lst-a lst-b)
  (cond ((not  lst-a) lst-b)
        ((not  lst-b) lst-a)
        #|((null (car lst-a)) lst-b)
        ((null (car lst-b)) lst-a)
        ((and (null (car lst-a)) ;caso tutte due NIL, vince a caso lst-a
              (null (car lst-b))) lst-a) |#
        ;((null (car lst-a)) (cons (car lst-b) (_merge2 lst-a (cdr lst-b))))
        ;((null (car lst-b)) (cons (car lst-a) (_merge2 (cdr lst-a) lst-b)))
        ((char< (char (string (third (car lst-a))) 0) 
                (char (string (third (car lst-b))) 0) ) 
         (cons (car lst-a) 
                                                              
               (_merge2 (cdr lst-a) lst-b)))
        (T (cons (car lst-b) (_merge2 lst-a (cdr lst-b))))))

(defun mergesort2 (lst)
  #|(if (eq (length lst) 1)
    lst
    (_merge2 (mergesort2 (list-head lst (truncate (length lst) 2)))
            (mergesort2 (list-tail lst (truncate (length lst) 2))))))|#
  (cond ((null lst) nil)
        ((eq (length lst) 1) lst)
        (T (_merge2 (mergesort2 (list-head lst (truncate (length lst) 2)))
                    (mergesort2 (list-tail lst (truncate (length lst) 2)))))))
;stampa il polinomio in forma di espressione
(defun pprint-polynomial (p) 
  (if (null p)
      nil
    (if (null (is-polynomial p))
        (pprint-polynomial (as-polynomial p))
      (format t "~s" (subseq (print-monomials (second p)) 1)))))

(defun print-monomials (ms) 
  (if (listp ms)
      (if (not (null ms))
          (let ((c (parse-coefficient (monomial-coefficient (first ms))))
                (vs (varpowers (first ms))))
            (cond ((and (> c 0) (not (eq c 1))) 
                   (concatenate 'string " +" (write-to-string c) " "
                                                             
                                (print-vars vs)
                                                             
                                (print-monomials (rest ms))))
                  ((< c 0) (concatenate 'string " " (write-to-string  c) " "
                                        (print-vars vs)
                                        (print-monomials (rest ms))))
                  ((eq c 1) (concatenate 'string  " + "
                                         (print-vars vs)
                                         (print-monomials (rest ms))))))
            ;(format t " ~d" c)
            ;(print-vars vs)
            ;(print-monomials (rest ms)))
            ;(format t "~d ~s ~s" c (print-vars vs) (print-monomials (rest ms))))
        nil)
    nil))

(defun print-vars (vs) 
  (if (listp vs)
      (if (not (null vs))  
                       (let ((power (second (first vs)))
                             (var (third (first vs))))
                         (cond 
                               ;((> power 1) (format t " ~s ^ ~d" var power))
                               ;((< power 0) (format t " ~s ^(- ~d)" var power))))
                              
 ((and (eq power 1) (null (rest vs)) 
       (concatenate 'string (string var) (print-vars (rest vs)))))
                              
 ((and (> power 1) (null (rest vs))) 
  (concatenate 'string (string var)  "^" (write-to-string power) 
               (print-vars (rest vs))))
                              
 ((and (< power 0) (null (rest vs))) 
  (concatenate 'string (string var)  "^ -(" (write-to-string power) ")"
               (print-vars (rest vs))))
                              
 ((eq power 1) (concatenate 'string (string var) " " 
                            (print-vars (rest vs))))
                              
 ((> power 1) (concatenate 'string (string var)  "^" 
                           (write-to-string power) " " 
                           (print-vars (rest vs))))
                              
 ((< power 0) (concatenate 'string (string var)  "^ -(" 
                           (write-to-string power) ") "
                           (print-vars (rest vs))))))
          nil)
    nil))

(defun ordina-stesso-grado (p g) 
  (if (<= g (maxdegree (append (list 'POLY p) )))
      (append (mergesort3 (estrai-stesso-grado p g)) 
              (ordina-stesso-grado p (+ g 1))) 
    nil))

(defun estrai-stesso-grado (p g) 
  (cond ((null (is-monomial (car p)))
         nil)
        ((eq (third (car p)) g) 
         (append (list (car p)) (estrai-stesso-grado (rest p) g)))
        (T (estrai-stesso-grado (rest p) g))))
         
(defun _merge3 (lst-a lst-b)
  (cond ((not lst-a) lst-b)
        ((not lst-b) lst-a)
        ((and (eq (third (car lst-a)) 0) 
              (< (second (car lst-a)) (second (car lst-b))))
         (cons (car lst-a) (_merge3 (cdr lst-a) lst-b)))
        ((and (eq (third (car lst-a)) 0) 
              (> (second (car lst-a)) (second (car lst-b))))
         (cons (car lst-b) (_merge3 lst-a (cdr lst-b))))
        
        ((and (same-varpowers lst-a lst-b)  
              (< (parse-coefficient (second (car lst-a))) 
                 (parse-coefficient (second (car lst-b)))))
         (cons (car lst-a) (_merge3 (cdr lst-a) lst-b)))
        ((and (same-varpowers lst-a lst-b)  
              (> (parse-coefficient (second (car lst-a))) 
                 (parse-coefficient (second (car lst-b)))))
         (cons (car lst-b) (_merge3 lst-a (cdr lst-b))))

        ((paragona-var-powers 
          (fourth (car lst-a)) (fourth (car lst-b)))  
         (cons (car lst-a) (_merge3 (cdr lst-a) lst-b)))
        (T (cons (car lst-b) (_merge3 lst-a (cdr lst-b))))))

(defun mergesort3 (lst)
  (cond ((null lst) nil)
        ((eq (length lst) 1) lst)
        (T (_merge3 (mergesort3 
                     (list-head lst (truncate (length lst) 2)))
                    (mergesort3 
                     (list-tail lst (truncate (length lst) 2)))))))
  
(defun paragona-var-powers (a b)
  (cond ((null a)
         nil)
        ((null b)
         T)
        ((char< (char (string (third (car a))) 0) 
                (char (string (third (car b))) 0) )
         T)
        ((char> (char (string (third (car a))) 0) 
                (char (string (third (car b))) 0) )
         nil)
        ((confronto-liste (var-symbols a) (var-symbols b))
         (paragona-powers a b))
        ((eq (third (car a)) (third (car b)))
         (paragona-var-powers (rest a) (rest b)))))

(defun paragona-powers (a b)
  (cond ((< (second (first a)) (second (first b)))
         T)
        ((> (second (first a)) (second (first b)))
         nil)
        ((and (eq (second (first a)) (second (first b))) (null (rest a)))
         T)
        ((eq (second (first a)) (second (first b)))
         (paragona-powers (rest a) (rest b)))))

(defun confronto-liste (a b)
  (if (eq (length a) (length b))
      (cond ((null (rest a))
             (if (eq (first a) (first b))
                 T
               nil))
            ((eq (first a) (first b))
             (confronto-liste (rest a) (rest b)))
            (T nil))
    nil))
             
(defun lista-gradi (vps) 
  (if (null vps)
      nil
    (flatten (list (second (first vps)) (lista-gradi (rest vps))))))

(defun same-varpowers (a b)
  (if (and (confronto-liste (var-symbols (fourth (car a))) 
                            (var-symbols (fourth (car b)))) 
           (confronto-liste (lista-gradi (fourth (car a))) 
                            (lista-gradi (fourth (car b)))))
      T
    nil))


(defun parse-polynomial (p) 
  (if (null (is-monomial (car p)))
      nil
    (let ((m (car p)))
      (append  (list (list (first m) 
                           (parse-coefficient 
                            (second m)) 
                           (third m) 
                           (fourth m))) 
               (parse-polynomial (rest p))))))

         