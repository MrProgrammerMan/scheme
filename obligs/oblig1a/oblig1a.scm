;; Oppgave 1
;;   a. (* (+ 4 2) 5)
;;      Dette er gyldig.
;;      Parameterene evalueres først (applikativ evalueringsrekkefølge).
;;        (* (+ 4 2) 5)
;;      = (* 6 5)
;;      = 30
;;   b. (* (+ 4 2) (5))
;;      Dette er ugyldig.
;;      *-operatoren fungerer ikke på lister. (5) er en liste mde tallet 5.
;;      Feilmelding: application: not a procedure; expected a procedure that can be applied to arguments given: 5
;;   c. (* (4 + 2) 5)
;;      Dette er ugyldig.
;;      Funksjonskall i scheme bruker alltid prefix-notasjon.
;;      4 er ikke er funksjon.
;;      Feilmelding: application: not a procedure; expected a procedure that can be applied to arguments given: 4
;;   d. (define bar (/ 44 2))
;;      bar
;;      Dette er gyldig.
;;      bar bindes til konstanten 44 / 2 = 22.
;;        bar
;;      = (/ 44 2)
;;      = 22
;;   e. (- bar 11)
;;      Dette er gyldig.
;;        (- bar 11)
;;      = (- 22 11)
;;      = 11
;;   f. (/ (* bar 3 4 1) bar)
;;      Dette er gyldig.
;;        (/ (* bar 3 4 1) bar)
;;      = (/ (* 22  3 4 1) 22)
;;      = (/ 264           22)
;;      = 12
;; Oppgave 2
;;   a.
;;     (or (= 1 2)
;;         "paff!"
;;         "piff!"
;;         (zero? (1 - 1)))
;;     Dette evaluerer til "paff!".
;;     'or' evaluerer verdien av det første argumentet som ikke er #f (false eller usant).
;;     På en måte er en verdi "sann" så lenge den ikke eksplisitt er #f.
;;     (and (= 1 2)
;;         "paff!"
;;         "piff!"
;;         (zero? (1 - 1)))
;;     Dette evaluerer til #f.
;;     'and' evaluerer til #f ved det første argumentet som evaluerer til #f.
;;     Kun hvis ingen av argumentene er #f evaluerer 'and' verdien til det siste argumentet.
;;     (if (positive? 42)
;;          "poff!"
;;          (i-am-undefined))
;;     Dette avaluerer til "poff!".
;;     'if' evaluerer det første argumentet sitt.
;;     Hvis denne verdien er #f, evaluerer 'if' til verdien av det tredje argumentet.
;;     Ellers evaluerer 'if' til verdien av det andre argumentet.
;;     Dersom 'or', 'and' og 'if' var vanlige prosedyrer ville alle argumentene deres ha blitt evaluert før de selv ble det.
;;     I så fall ville syntaksfeilene og de udefinerte prosedyrene kastet feilmeldinger.
;;     Siden dette ikke skjer ser vi at disse spesielle formene ikke følger det vanlige evalueringsreglene.
;;     Alle de tre formene er "short-circuiting" og ender ikke nødvendigvis opp med å evaluere alle argumenter.
;;   b.
(define (sign-cond n)
  (cond ((= n 0) 0)
        ((positive? n) 1)
        (else -1)))
(define (sign-if n)
  (if (= n 0)
      0
      (if (positive? n)
          1
          -1)))
(define sign sign-cond)
;;   c.
(define (sign-log n)
  (or (and (zero? n) 0)
      (and (positive? n) 1)
      -1))
;; Oppgave 3
;;   a.
(define (add1 n) (+ n 1))
(define (sub1 n) (- n 1))

;;   b. Prosedyren under er renamed til '-iter' for klarere kontrast i oppgaven under. Den fungerer kun hvis y >= 0. Annet var ikke påkrevd i oppgaven. (Kunne være løst med noen ekstra tester)
(define (add-two-iter x y)
  (if (zero? y)
      x
      (add-two-iter (add1 x) (sub1 y))))
;;   c.
;;      'add-two-iter' gir opphav til en iterativ prosess.
;;      Evalueringen er simulert her:
;;        (add-two-iter 5 2)
;;      = (add-two-iter (add1 5) (sub1 2))
;;      = (add-two-iter 6 1)
;;      = (add-two-iter (add1 6) (sub1 1))
;;      = (add-two-iter 7 0)
;;      = 7
;;      Grunnen til at dette er en iterativ prosess er at den ikke avhenger av informasjon fra tidligere kall for å evaluere det endelige resultatet.
;;      Det eneste det rekursive kallet gjør er å "henvise til et nytt kall til seg selv med nye argumenter, hvor resultatet returneres oppover".
;;      Med andre ord itererer prosedyren.
;;
;;      En enkel måte å se at prosessen er iterativ er at prosedyren er hale-rekursiv. Det rekursive kallet er det siste prosedyren gjør.
;;      Dette er det samme som å si at prosedyren "forbedrer argumentene" og itererer.
;;
;;      Rekursive prosesser gir typisk opphav til "trekkspillaktig" evaluering, hvor resultatet fra et rekursivt kall må behandles ytterligere på vei opp callstacken.
;;      Iterative prosesser er ofte mer minneeffektive fordi de kan deallokere stackframen til "morkall" umiddelbart ettersom disse har gjort jobben sin ferdig innen det rekursive kallet.
;;
;;      Nødvendig informasjon i rekursive kall til iterative prosesser er lagret i argumentene, noen ganger kalt tilstandsvariabler.
;;      I rekursive prosesser er tilstanden avhengig av den fulle callstacken.
(define (add-two x y)
  (if (zero? y)
      x
      (add1 (add-two x (sub1 y)))))
;;      'add-two' gir opphav til en rekursiv prosess.
;;      simulering av evaluering av metoden:
;;        (add-two 5 3)
;;      = (add1 (add-two 5 (sub1 3)))
;;      = (add1 (add-two 5 2))
;;      = (add1 (add1 (add-two 5 (sub1 2))))
;;      = (add1 (add1 (add-two 5 1)))
;;      = (add1 (add1 (add1 (add-two 5 (sub1 1)))))
;;      = (add1 (add1 (add1 (add-two 5 0))))
;;      = (add1 (add1 (add1 5)))
;;      = (add1 (add1 6))
;;      = (add1 7)
;;      = 8
;;   d.
(define (power-close-to b n)
  (define (power-iter e)
    (if (> (expt b e) n)
        e
        (power-iter (+ 1 e))))
  (power-iter 1))
;;     Prosedyren skrevet om til blokkstruktur gjør at b og n er i scope til power-iter.
;;     Vi trenger altså ikke å gi disse som argument, men kan la power-iter benytte de direkte fra topp-nivå-argumentene.
;;   e.
(define (fib n)
  (define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))
;;     Vi kan ikke forenkle denne videre.
;;     Grunnen til dette er at vi behøver tilstandsvariabler for de 2 foregående fibonaccitallene samt en teller for å vite når vi skal stoppe utregningen.
;;     Prosedyren benytter ikke flere argumenter enn det, og vi kan ikke fjerne noen uten å ødelegge funksjonaliteten til prosedyren.
;;     (Vi kunne forenklet definisjonen hvis vi gjorde den rekursiv på bekostning av ressursbruk)

;; ============================
;; Testkall generert av KI- kan ignoreres
;; ============================

(display "sign-cond -5 = ") (display (sign-cond -5)) (newline)
(display "sign-cond 0 = ")  (display (sign-cond 0)) (newline)
(display "sign-cond 7 = ")  (display (sign-cond 7)) (newline)

(display "sign-if -5 = ") (display (sign-if -5)) (newline)
(display "sign-if 0 = ")  (display (sign-if 0)) (newline)
(display "sign-if 7 = ")  (display (sign-if 7)) (newline)

(display "sign-log -5 = ") (display (sign-log -5)) (newline)
(display "sign-log 0 = ")  (display (sign-log 0)) (newline)
(display "sign-log 7 = ")  (display (sign-log 7)) (newline)

(display "(add1 3) = ") (display (add1 3)) (newline)
(display "(sub1 2) = ") (display (sub1 2)) (newline)
(display "(add1 (sub1 0)) = ") (display (add1 (sub1 0))) (newline)

(display "(add-two-iter 5 2) = ") (display (add-two-iter 5 2)) (newline)
(display "(add-two 5 3) = ") (display (add-two 5 3)) (newline)

(display "(power-close-to 2 8) = ") (display (power-close-to 2 8)) (newline)
(display "(power-close-to 3 20) = ") (display (power-close-to 3 20)) (newline)

(display "(fib 0) = ") (display (fib 0)) (newline)
(display "(fib 1) = ") (display (fib 1)) (newline)
(display "(fib 10) = ") (display (fib 10)) (newline)