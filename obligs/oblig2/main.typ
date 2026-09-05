#set page(paper: "a4", margin: 2.5cm)
#set text(size: 11pt)
#set text(lang: "nb")

#align(center + horizon)[
  #text(2em, weight: "bold")[IN2040 - oblig 2]
  #v(10pt)
  Jonas Hazeland Baugerud \
  #datetime.today().display()
]

#v(250pt)

Dette dokumentet inneholder svar på tegne-oppgavene i oblig 2. Jeg har også vedlagt scheme-koden, men den er identisk til den som ligger i oblig2.scm(levert sammen med dokumentet).

#pagebreak()

#outline(
  title: "Innhold",
  depth: 3,
)

#pagebreak()

= Oppgave 1

#block(width: 100%, breakable: false)[
  == a.
  Expression: `(cons 42 11)` \
  Verdi(som vist i REPL): `(42 . 11)`

  _Merk: boksene 42 og 11 ikke skal se ut som de henger sammen. Dette var slik verktøyet jeg brukte tegnet de._
  #align(center)[
    #figure(
      image(
        "diagrams/1a.svg",
      ),
      caption: [(cons 42 11)]
    )
  ]
]

#block(width: 100%, breakable: false)[
  == b.
  Expression: `(cons 42 '())` \
  Verdi(som vist i REPL): `(42)`

  #align(center)[
    #figure(
      image(
        "diagrams/1b.svg", width: 60%
      ),
      caption: [(cons 42 '())]
    )
  ]
]

#block(width: 100%, breakable: false)[
  == c.
  Expression: `(list 42 11)` \
  Verdi(som vist i REPL): `(42 11)`
  #align(center)[
    #figure(
      image(
        "diagrams/1c.svg",
      ),
      caption: [(list 42 11)]
    )
  ]
]

#block(width: 100%, breakable: false)[
  == d.
  Expression: `'(42 (11 12))` \
  Verdi(som vist i REPL): `(42 (11 12))`

  #align(center)[
    #figure(
      image(
        "diagrams/1d.svg",
      ),
      caption: ['(42 (11 12))]
    )
  ]
]

#block(width: 100%, breakable: false)[
  == e.
  Expression: `(define foo (list 1 2 3)) (cons foo foo)` \
  Verdi(som vist i REPL): `((1 2 3) 1 2 3)`

  #align(center)[
    #figure(
      image(
        "diagrams/1e.svg",
      ),
      caption: [(define foo (list 1 2 3)) (cons foo foo)]
    )
  ]
]
