#set page(paper: "a4", margin: 2.5cm)
#set text(size: 11pt)
#set text(lang: "nb")

#align(center + horizon)[
  #text(2em, weight: "bold")[IN2040 - oblig 2b]
  #v(10pt)
  Jonas Hazeland Baugerud \
  #datetime.today().display()
]

#v(250pt)

Dette dokumentet inneholder svar på tegne-oppgavene i oblig 2b. Jeg har også vedlagt scheme-koden, men den er identisk til den som ligger i oblig2b.scm(levert sammen med dokumentet).

#pagebreak()

#outline(
  title: "Innhold",
  depth: 3,
)

#pagebreak()

= Oppgave 1

#block(width: 100%, breakable: false)[
  == a.
  Se kildekode.
]

#block(width: 100%, breakable: false)[
  == b.
  @komplett viser en "relativt komplett" omgivelsesmodell for kallet `(c2)`. #v(2pt)
  Fra venstre ser vi bindinger for de primitive prosedyrene `+` og `set!`, som benyttes i de andre prosedyrene. #v(2pt)
  Ved å kalle `make-counter` opprettes det først en frame hvor alle parameter bindes. Siden `make-counter` ikke har noen parametere er denne framen tom. Den anonyme prosedyren `let`-bindingen desukres til kjøres også, som oppretter enda en frame og binder `count` til 0. Dette gir opphav til strukturen i diagrammet med 2 nye frames per kall til `make-counter`. #v(2pt)

  Kjøringen av `(c2)` er vist ved framen `E`. Her bindes parameterene til kallet (ingen) til den nye framen(tom). Øyeblikket som er modellert er rett før `set!` utføres, som ville satt count i forelderen til `E` til 1. #v(2pt)

  @forenklet viser et forenklet diagram. Her er de tomme framene til parameterløse prosedyrekall fjernet, samt de primitive prosedyrene.

  #align(center)[
    #figure(
      image(
        "diagrams/c2-env-diagram.svg",
      ),
      caption: [Komplett omgivelsesdiagram over kjøringen av `(c2)` i oppgave 1b.]
    ) <komplett>
  ]
]

#block(width: 100%, breakable: false)[
  Mer simplified versjon under.

  #align(center)[
    #figure(
      image(
        "diagrams/c2-env-diagram-simplified.svg",
      ),
      caption: [Forenklet omgivelsesmodell for kall til `(c2)` i oppgave 1b.]
    ) <forenklet>
  ]
]

= Oppgave 2

#block(width: 100%, breakable: false)[
  == a.
  Se kildekode.
]

#block(width: 100%, breakable: false)[
  == b.
  Se kildekode.
]

= Oppgave 3

#block(width: 100%, breakable: false)[
  == a.
  @liste viser lister før kallet til `set-cdr!`. @syklisk viser hvordan listen ser ut etter kallet. #v(2pt)
  Vi kan se at dersom vi gjentatte ganger kaller `cdr` på listen, vil vi ende opp i syklusen `b-c-d`. Dette observerer vi også `list-ref`, som gjør nettopp dette. Verdiene av listen blir `a-b-c-d-b-c-d-b-c-...`. `list-ref 0` er altså `a`, men deretter vil `list-ref` av `n+1` gi det samme resultatet som `list-ref` av `(n mod 3) + 1`.

  #align(center)[
    #figure(
      image(
        "diagrams/bar-cons-diagram.svg", width: 60%
      ),
      caption: [Resultatet av `(list 'a 'b 'c 'd 'e)`]
    ) <liste>
  ]

  #align(center)[
    #figure(
      image(
        "diagrams/bar-cons-diagram-cyclic.svg", width: 60%
      ),
      caption: [liste nå med sykel]
    ) <syklisk>
  ]
]

#block(width: 100%, breakable: false)[
  == b.
  @towel viser listen før det første kallet på `set-car!`. @rart viser listen etter det første kallet, men før det andre kallet. #v(2pt)

  Vi benytter `set-car!` på `(car bah)`, eller 42. Denne verdien er delt og vises 2 steder i listen vår. Når vi reassigner den vil den endres begge steder. Derfor gir det mening at vi får `((42 towel) 42 towel)` etter det siste kallet.

  #align(center)[
    #figure(
      image(
        "diagrams/towel-cons-diagram.svg", width: 60%
      ),
      caption: [towel]
    ) <towel>
  ]

  #align(center)[
    #figure(
      image(
        "diagrams/towel-cons-diagram-weird.svg", width: 60%
      ),
      caption: [weird towel]
    ) <rart>
  ]

  Det ville endre flere steder ja.
]

#block(width: 100%, breakable: false)[
  == c.
  Se kildekode.
]

#block(width: 100%, breakable: false)[
  == d.
  `list?`-predikatet virker ved følgende algoritme:
  1. Den tomme listen er en liste. \
  2. Par er en liste dersom `cdr` av paret er en liste. \
  Med andre ord kalles `cdr` inntil man treffer den tomme listen. Siden sykliske lister ikke inneholder den tomme listen, vil de ikke oppfylle denne testen.
]

#pagebreak()

#show raw.where(block: true): set block(width: 100%)

= *Appendix (kopi av kode)*

#text(size: 9pt)[oblig2b.scm, ligger også vedlagt ved siden av dette dokumentet.] 

#raw( read("code/oblig2b.scm"), lang: "lisp", block: true, )