#let header(title) = {
  block(width: 5.5in, {
        // We need to define line widths to reuse them in spacing.
        let top-rule-width = 4pt
        let bot-rule-width = 1pt

      // Add some space based on line width.
      v(0.1in + top-rule-width / 2)
      line(length: 100%, stroke: top-rule-width + black)
      align(center, text(size: 17pt, weight: "bold", [#title]))
      v(-bot-rule-width)
      line(length: 100%, stroke: bot-rule-width + black)
    })
}

#let make_figure_caption(it) = {
  set align(center)
  block(width: 100%, {
    set align(left)
    set text(size: 9pt)
    emph({
      it.supplement
      if it.numbering != none {
        [ ]
        //it.counter.display(it.numbering)
      }
      it.separator
    })
    [ ]
    it.body
  })
}

#let make_figure(caption_above: false, it) = {
  // set align(center + top)
  place(center + top, float: true,
  block(breakable: false, width: 100%, {
    if caption_above {
      it.caption
    }
    v(0.1in, weak: true)
    it.body
    v(0.1in, weak: true)
    if not caption_above {
      it.caption
    }
  }))
}

#let h_authors(authors) = {
      // Display the authors list.
  block(width: 100%, {
    set text(size: 10pt)
    set par(leading: 4.5pt)
    set par(leading: 0.6em)
    for i in range(calc.ceil(authors.len() / 3)) {
    let end = calc.min((i + 1) * 3, authors.len())
    let is-last = authors.len() == end
    let slice = authors.slice(i * 3, end)
    grid(
      columns: slice.len() * (1fr,),
      gutter: 12pt,
      ..slice.map(author => align(center, {
        text(size: 11pt, author.name, weight: "bold")
        if "department" in author [\ #emph(author.department)]
        if "institution" in author [\ #emph(author.institution)]
        if "location" in author [\ #author.location]
        if "email" in author {
          if type(author.email) == str [\ #link("mailto:" + author.email)] else [\ #author.email]
            }
        }
      )
      )
    )
    if not is-last {
      v(16pt, weak: true)
      }
    }
  })
}

#let h_abstract(abstract) = {
  block(width: 100%, {
    set text(size: 10pt)
    set text(size: 10pt)
    set par(leading: 0.43em)  // Original 0.55em (or 0.45em?).

    // NeurIPS instruction tels that font size of `Abstract` must equal to 12pt
    // but there is not predefined font size.
    align(center, text(size: 12pt)[*Abstract*])
    v(0.215em)  // Original 0.5ex.
    pad(left: 0.5in, right: 0.5in, abstract)
    v(0.43em)  // Original 0.5ex.
  })
}

#let font-family = ("TeX Gyre Termes")
#let project(
  title: "",
  abstract: "asd",
  authors: (),
  keywords: (),
  date: datetime.today(),
  bibliography: none,
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title, keywords: keywords, date: date)
  set page(
    paper: "us-letter",
    margin: (left: 1.5in, right: 1.5in, top: 1.0in, bottom: 1in),
    numbering: "1", number-align: center)

  //Title
  show ref: r => {underline(offset: 2pt, stroke: 0.2pt + blue, emph(r))}
  show link: l => {text(fill: blue,underline(offset: 2pt, stroke: 0.2pt, emph(l)))}
  show cite: set text(size: 0.7em)

  // Main body.
  set par(justify: true, leading: 0.55em)
  set text(font: font-family, size: 10pt)

  show quote: set align(left)
  show quote: set pad(x: 4em)
  show quote: set block(spacing: 1em)  // Original 11pt.

  show raw.where(block: true): set block(spacing: 14pt)

  show list: set block(spacing: 15pt)  // Original unknown.
  set list(
    indent: 30pt,  // Original 3pc (=36pt) without bullet.
    spacing: 8.5pt)
  set heading(numbering: "1.1")
  show heading: it => {
    // Create the heading numbering.
    let number = if it.numbering != none {
      counter(heading).display(it.numbering)
    }

    set align(left)
    if it.level == 1 {
      // TODO: font.large?
      text(size: 12pt, weight: "bold", {
        let ex = 7.95pt
        v(2.7 * ex, weak: true)
        [#number *#it.body*]
        v(2 * ex, weak: true)
      })
    } else if it.level == 2 {
      text(size: 10pt, weight: "bold", {
        let ex = 6.62pt
        v(2.70 * ex, weak: true)
        [#number *#it.body*]
        v(2.03 * ex, weak: true)  // Original 1ex.
      })
    } else if it.level == 3 {
      text(size: 10pt, weight: "bold", {
        let ex = 6.62pt
        v(2.6 * ex, weak: true)
        [#number *#it.body*]
        v(1.8 * ex, weak: true)  // Original -1em.
      })
    }
  }
  set figure.caption(separator: [:])
  show figure: set block(breakable: false)
  show figure.caption.where(kind: table): it => make_figure_caption(it)
  show figure.caption.where(kind: image): it => make_figure_caption(it)
  show figure.where(kind: image): it => make_figure(it)
  show figure.where(kind: table): it => make_figure(it, caption_above: true)
  counter(figure.where(kind: "algorithm")).update(0)
  show figure.caption.where(kind: "algorithm"): it => {
    strong[#it.supplement #it.counter.display(it.numbering)]
    [ ]
    it.body
  }
  show figure.where(kind: "algorithm"): it => {
    place(top, float: true,
      block(breakable: false, width: 100%, {
        set block(spacing: 0em)
        line(length: 100%, stroke: (thickness: 0.08em))
        block(spacing: 0.4em, it.caption)  // NOTE: No idea why we need it.
        line(length: 100%, stroke: (thickness: 0.05em))
        it.body
        line(length: 100%, stroke: (thickness: 0.08em))
      })
    )
  }
  show std.bibliography: set text(8pt)
  show std.bibliography: set block(spacing: 0.5em)
  set std.bibliography(title: text(10pt)[References], full: true, style: "ieee")

  {
    place(
    top,
    float: true,
    scope: "parent",
    clearance: 30pt,
    {   
      header(title)
      v(0.25in)
      h_authors(authors)
      v(6.5pt)
      h_abstract(abstract)
    }
  )
  }
  
  // Render main body
  {
    // Display body.
    set text(size: 11pt)
    set par(leading: 0.43em)
    //show par: set block(spacing: 1.0em)  // Original 11pt.
    body

    bibliography
  }
}
