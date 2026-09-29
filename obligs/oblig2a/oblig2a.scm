(load "huffman.scm")

;; NB!: Jeg har ikke jobbet i gruppe.

(display "1a.") ;; Disse er lagt inn for å gjøre det enklere å lese output
(newline)
;; Oppgave 1
;;   a.
(define (p-car p) (p (lambda (x y) x)))
(define (p-cdr p) (p (lambda (x y) y)))

;; TESTING
(define (p-cons x y)
  (lambda (proc) (proc x y)))

(p-car (p-cons "foo" "bar"))
(p-cdr (p-cons "foo" "bar"))
(p-car (p-cdr (p-cons "zoo" (p-cons "foo" "bar"))))

(display "1b.")
(newline)
;;   b.
(define foo 42) ;; For at koden skal kjøre

(let ((foo 5) ;; Til sammenligning
      (x foo))
  (if (= x foo)
      'same
      'different))

;; --- 1 ---
((lambda (foo x)
   (if (= x foo)
       'same
       'different))
 5 foo)

;; Verdiene av uttrykkene over er different.
;; Dette skyldes at foo lokalt i kroppen til let-uttrykket refererer til foo satt til 5.
;; Imidlertid referer x til foo satt til 42 globalt.
;; Bindingene i let-uttrykket kan overskygge de "mer globale" bindingene.
;; Dette er enda tydeligere i lambdauttrykket, som kalles med 5 og 42.

(let ((bar foo) ;; Til sammenligning
      (baz 'towel))
  (let ((bar (list bar baz))
        (foo baz))
    (list foo bar)))

;; --- 2 ---
((lambda (bar baz)
   ((lambda (bar foo)
      (list foo bar))
    (list bar baz) baz))
 foo 'towel)

;; Verdien av uttrykkene over er (towel (42 towel)).
;; I første lett bindes bar til 42 og baz til 'towel.
;; I andre let bindes bar til '(42 towel) og foo til 'towel.
;; (list 'towel '(42 towel)) evaluerer til (towel (42 towel)).

(display "1c.")
(newline)
;;   c.
(define (infix-eval l)
  ((cadr l) (car l) (caddr l)))

;; For at koden skal kjøre
(define foo (list 21 + 21))
(define baz (list 21 list 21))
(define bar (list 84 / 2))

;;      Dette evaluerer til (+ 21 21) = 42
(infix-eval foo)
;;      Dette evaluerer til (list 21 21) = (21 21)
(infix-eval baz)
;;      Dette evaluerer til (/ 84 2) = 42
(infix-eval bar)

(display "1d. (ingen kode med output)")
(newline)
;;   d.
(define bah '(84 / 2))
;(infix-eval bah)
;;      Metodekallet gir feilmelding som sier / ikke er en prosedyre som kan kalles.
;;      Dette skyldes at vi ikke evaluerer / som "prosedyren som deler to tall", men heller direkte som "symbolet /".
;;      Dette skjer fordi vi har en quote foran listen, slik at den tolkes bokstavelig.

(display "2a. (ingen kode med output)")
(newline)
;; Oppgave 2
;;   a.
;;      Siden dekodingen naturlig reverserer resultatet, reverses det igjen etter at den halerekursive dekodingen er ferdig.
;;      Dette er generelt en bedre løsning enn å eksempelvis bruke append underveis, som gjør prosedyren langt tregere.
(define (decode bits tree)
  (define (decode-1 bits current-branch message)
    (if (null? bits)
        message
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (decode-1 (cdr bits) tree (cons (symbol-leaf next-branch) message))
              (decode-1 (cdr bits) next-branch message)))))
  (reverse (decode-1 bits tree '())))

(display "2b.")
(newline)
;;   b.
;;      Resultatet av dekoding av sample-koden blir (samurais fight ninjas by night).
(decode sample-code sample-tree)

(display "2c.")
(newline)
;;   c.
;;      Idéen her er å generere et lookup-table som assosierer hvert symbol til en bitsekvens.
;;      Vi gjør dette først fordi det hadde vært veldig ytelsesmessig tungt å traversere treet for hvert symbol.
;;      Huffman-koding involverer vanligvis at koden for treet som er brukt sendes sammen med den kodede meldingen.
;;      Siden dette i seg selv tar plass er det bare logisk å gjøre det hvis man har en vesentlig mengde symboler å enkode.
;;      Derfor foretrekker vi å traversere hele treet én gang og generere en komplett ordbok.
;;      I teorien kan dette være mindre effektivt med veldig korte eksempler som bruker bare få tegn, men dette er ikke veldig relevant.
;;      Merk at encode-dictionary er curried, slik at dictionarien kan preapplikeres til prosedyren.
;;      Deretter er resultatprosedyren kompatibel med map.
;;      flatten er inkludert kun for å vise at logikken er forstått.
(define (encode symbols tree)
  ;; Wrapper
  (define (generate-dictionary root)
    ;; Genererer en dictionary på formen ((a 0 1 1) (b 1 0) ...)
    ;; Første element i et av elementene i dictionaryen svarer til et symbol som kan enkodes.
    ;; Resten av elementet svarer til bitsekvensen symbolet skal enkodes til.
    (define (generate-dictionary-1 current-node current-path)
      (if (leaf? current-node)
          (list (cons (symbol-leaf current-node) (reverse current-path)))
          (append (generate-dictionary-1 (left-branch current-node) (cons 0 current-path))
                  (generate-dictionary-1 (right-branch current-node) (cons 1 current-path)))))
    (generate-dictionary-1 root '()))
  ;; Gir ut bitsekvensen til et symbol dersom det eksisterer i dictionary.
  ;; Prosedyren crasher hvis symbolet ikke finnes i dictionary.
  (define (encode-symbol dictionary)
    (lambda (symbol)
      (if (equal? symbol (caar dictionary))
          (cdr (car dictionary))
          ((encode-symbol (cdr dictionary)) symbol))))
  ;; Generer en dictionary fra treet og preappliker denne til encode-symbol.
  ;; Anvend den resulterende enkodingsprosedyren til hvert symbol.
  ;; Append resultatlistene sammen. ('apply append' flater ut ett nivå med nøstede lister)
  (apply append (map (encode-symbol (generate-dictionary tree)) symbols)))

;; TESTING
(decode (encode '(ninjas fight ninjas) sample-tree) sample-tree)

(display "2d.")
(newline)
;;   d.
(define (grow-huffman-tree freqs)
  (define (ght leaf-set)
    (if (= (length leaf-set) 1)
        (car leaf-set)
        (ght
         (adjoin-set (make-code-tree (car leaf-set) (cadr leaf-set))
                     (cddr leaf-set)))))
  (ght (make-leaf-set freqs)))

;; TESTING
(define freqs '((a 2) (b 5) (c 1) (d 3) (e 1) (f 3)))
(define codebook (grow-huffman-tree freqs))
(decode (encode '(a b c) codebook) codebook)

(display "2e.")
(newline)
;;   e.
(define freqs '((samurais 57) (ninjas 20) (fight 45) (night 12) (hide 3) (in 2) (ambush 2) (defeat 1) (the 5) (sword 4) (by 12) (assassin 1) (river 2) (forest 1) (wait 1) (poison 1)))
(define codebook (grow-huffman-tree freqs))
(define msg '(       ninjas fight
                     ninjas fight ninjas
                     ninjas fight samurais
                     samurais fight
                     samurais fight ninjas
                     ninjas fight by night))
(define encoded-msg (encode msg codebook)) ;; Enkod
(display encoded-msg) ;; Vis kode
(newline)
(display (length encoded-msg)) ;; Lengden til koden
;;      Det brukes 43 bits for å kode meldingen.
(newline)
(display (length msg)) ;; Lengden til meldingen
(newline)
(display (/ (length encoded-msg) (length msg))) ;; Forholdet mellom de
(newline)
(display (* 1.0 (/ (length encoded-msg) (length msg)))) ;; Forholdet i desimalform
;;      Gjennomsnittlig antall bits per ord i denne meldingen med denne kodeboken er 43/17 eller ca. 2.5
(newline)
;;      Det er 16 forskjellige symboler som kan enkodes med alfabetet over.
;;      log_2(16)=4. Derfor må vi ha 4 bits per symbol.
;;      Siden meldingen inneholder 17 symboler blir den totale meldingslengden da 4*17=68.
(* 100 (- 1.0 (/ (length encoded-msg) (* 4 17)))) ;; Spart plass i prosent
;;      Vi har altså spart omkring 37% plass.

(display "2f.")
(newline)
;;   f.
(define (huffman-leaves tree)
  (if (leaf? tree)
      (list (list (symbol-leaf tree) (weight-leaf tree))) ;; Nøstet-liste-struktur
      (append (huffman-leaves (left-branch tree))
              (huffman-leaves (right-branch tree)))))

;; TESTING
(huffman-leaves sample-tree)