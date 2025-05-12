#import "@preview/nth:1.0.1": nths
#let conf(
  title: "",
  authors: (
    [Thomas Holme Surlykke \ `tkm218`],
  ),
  doc,
) = {
  set par(justify: true)
  set page(numbering: "1/1")
  align(center)[
    #text(1.8em, title)

    #set text(1.2em)

    #let today = datetime.today()
    #today.display("[weekday repr:long], [month repr:long]")
    #nths(today.day())


    #let count = authors.len()
    #let ncols = calc.min(count, 3)
    #grid(
      columns: (1fr,) * ncols,
      row-gutter: 24pt,
      ..authors
    )
  ]
  doc
}


#let appendix(body) = {
  // let appendixnumbering(..args) = {
  //   if args.pos().len() == 1 {
  //     [Appendix #numbering("A.1.1", ..args) ---]
  //   } else { numbering("A1.1 ", ..args) }
  // }
  // set heading(numbering: appendixnumbering, supplement: [])
  set heading(numbering: "A1.1 ", supplement: [Appendix])
  set figure(numbering: n => {
    let sec = context (counter(headign).get().at(0))
    let letter = numbering("A")
    let section_letter = context numbering("A", counter)
    let hdr = counter(heading).get().first()
    let num = query(selector(heading).before(here())).last().numbering
    numbering(num, hdr, n)
  })
  show figure: set block(breakable: true)
  pagebreak()
  align(center, text(size: 1.6em, weight: "bold", "Appendix"))
  v(1em)
  body
}
