# IKU Thesis Template (LaTeX)

An unofficial, community LaTeX template for **Istanbul Kültür University (İKÜ)**
graduate theses, built to follow the university's *Thesis Writing Guide*.

It is **bilingual** — write your thesis in **Turkish (default)** or **English**
by changing a single flag — and supports **Master's, Doctoral, and
Proficiency-in-Art** degrees. It is designed to compile out of the box on
**Overleaf** and on local TeX distributions.

> This template is a student-made gift to the İKÜ community. It is not an
> official university document. Always check the current official guide and your
> institute's requirements before submission.

Created and maintained by **Fatih Çalık** ([@fatih-ml](https://github.com/fatih-ml)).
Free to use and share under the MIT License — please keep the attribution.

## Features

- A4 paper; margins **left 4 cm**, **right/top/bottom 2.5 cm** (per the guide).
- Times New Roman (via `newtx`), 12 pt, **1.5 line spacing**.
- Roman page numbers for the front matter, Arabic for the body, centered at the
  bottom — with the preface as page `i` (unprinted).
- Auto-generated **outer cover (dış kapak)** and **inner cover (iç kapak)** —
  following the Institute of Graduate Studies' current official cover format,
  where the inner cover carries the **jury signature section** (no separate
  approval page). Plus **declaration**, **preface**, **table of contents**,
  lists of **tables/figures/symbols**, **abbreviations**, and both mandatory
  abstracts (**ÖZ** + **ABSTRACT**).
- Heading hierarchy and spacing matching the guide; primary headings begin
  ~5 cm from the top edge.
- `Table 1.2` / `Figure 1.1` numbering (per chapter); appendices use `A.1`.
- **MLA** references via `biblatex` + `biber`, with a Turkish localization
  (`turkish-mla.lbx`) for the guide's citation abbreviations.

## Quick start

### Overleaf (recommended)
1. Download this repository as a ZIP (`Code → Download ZIP`) or clone it.
2. In Overleaf: `New Project → Upload Project` and select the ZIP.
3. Overleaf reads `latexmkrc` automatically. Make sure the compiler is
   **pdfLaTeX** (Menu → Compiler). `biber` runs automatically.
4. Open `main.tex` and press **Recompile** — Overleaf re-runs everything (LaTeX,
   biber, LaTeX again) and updates the PDF preview on the right. Turn on
   *Auto Compile* (next to the Recompile button) to rebuild on every change.

### Local build
Requires a TeX distribution (TeX Live / MiKTeX) with `newtx`, `biblatex`,
`biblatex-mla`, `titlesec`, `tocloft`, `textpos`, and `biber`.

```bash
latexmk -pdf main.tex
```

`latexmk` runs LaTeX and biber as many times as needed and produces `main.pdf`.
Without `latexmk`, run the full cycle by hand:

```bash
pdflatex main
biber main
pdflatex main
pdflatex main
```

### How recompiling works (and Cmd/Ctrl+S)

LaTeX is *not* a live word processor: editing a `.tex` file does not update the
PDF until you **recompile**. How you trigger that depends on where you edit:

- **Overleaf:** click **Recompile** (or enable *Auto Compile* to rebuild on
  save). The PDF preview updates automatically.
- **VS Code** with the *LaTeX Workshop* extension: it compiles automatically on
  save (**Cmd/Ctrl+S**) and shows the PDF in a side tab (see "VS Code setup").
- **TeXstudio / TeXmaker / TeXShop:** press the **Build/Compile** (green
  arrow) button, or its shortcut (e.g. **F5** in TeXstudio).
- **Plain terminal:** re-run `latexmk -pdf main.tex` after each change.

Because the bibliography uses `biber`, a *full* build is LaTeX → biber → LaTeX →
LaTeX. `latexmk` and Overleaf handle this for you; only a manual `pdflatex` needs
the extra passes (citations/links may show as `?` until the second LaTeX run).

### VS Code setup

The repo ships a `.vscode/settings.json` that, with the **LaTeX Workshop**
extension, gives you — **with no extra downloads**:

- **Soft word-wrap** — long lines wrap to the window in both the editor and the
  diff/compare view, so you never scroll right. You can keep a paragraph as one
  long line and still read it wrapped, including when reviewing a Git diff (the
  changed words are highlighted within the wrapped line).
- **Build on save** — the PDF refreshes when you save. The recipe runs
  `pdflatex` + `biber` directly (both are in every TeX install), so it does
  **not** require `latexmk`.

Nothing to install for the above. (On Overleaf, builds use Overleaf's own
toolchain and this file is ignored.)

> Optional, only if you want automatic *hard-wrapping* of prose to a fixed
> column width: install `latexindent` (`sudo tlmgr install latexindent`) and add
> a format-on-save block to `.vscode/settings.json`. Not needed for the
> wrap-on-display behaviour above.

## Choosing language and degree

Edit the very first line of `main.tex`:

```latex
\documentclass[turkish,ms]{iku-thesis}
```

- **Language:** `turkish` (default) or `english`. This one flag switches every
  fixed heading/label and babel's main language. Both abstracts (ÖZ and
  ABSTRACT) are always printed, as the guide requires.
- **Degree:** `ms` (master's, default), `phd` (doctorate), or `arts`
  (proficiency-in-art). This sets the thesis-type wording on the cover.

For an **English** thesis, also uncomment `\maketurkishinnercover` in `main.tex`
— a Turkish inner cover is added for foreign-language theses.

## Filling in your thesis

Everything that identifies your thesis lives in **`metadata.tex`**: title (TR and
EN), author, student number, institute/department/programme (TR and EN), advisor
and co-advisor, jury members, dates, and keywords. Edit that file first.

Prose front matter lives in **`frontmatter/`**:
`preface.tex`, `abstract-tr.tex`, `abstract-en.tex`, `abbreviations.tex`,
`symbols.tex`, `declaration.tex`.

### Writing bilingual text

Inside content files, use `\bilingual{<Turkish>}{<English>}` to provide both
versions in one place; the active language is printed automatically. The example
sections show the pattern. (Single-language files such as `abstract-tr.tex` are
written directly in that language.)

## Repository layout

```
main.tex            Entry point: options + front-matter order + section inputs
metadata.tex        Your thesis information (fill this in)
iku-thesis.cls      The document class (all formatting logic)
turkish-mla.lbx     Turkish localization for MLA citations
references.bib      Bibliography database
sections/           One .tex per section (numeric prefixes set the order)
tables/             One .tex per table (each a self-contained float)
figures/            Figures as PDF (sources kept alongside as .tex)
appendices/         One .tex per appendix
frontmatter/        Preface, abstracts, abbreviations, symbols, declaration
```

### Adding content

- **Section:** create `sections/04-results.tex` starting with
  `\chapter{...}`, then add `\input{sections/04-results}` in `main.tex`.
- **Table:** create `tables/my-table.tex` containing a `table` float (caption
  **above** the table), then `\inputtable{my-table}` where you want it.
- **Figure:** put a **PDF** in `figures/` (e.g. `figures/plot.pdf`), then
  `\thesisfigure{plot}{Caption}{fig:plot}` (caption is placed **below**).

### Splitting one section across several files

A section can be a single file **or** a folder of several files — both look
identical in the body and the Table of Contents, because the TOC is built from
the `\chapter`/`\section`/`\subsection` commands, not from how files are
arranged. Section 3 (`sections/03-method/`) demonstrates the folder pattern.

To split a section:

1. Make a folder, e.g. `sections/04-results/`.
2. Put the `\chapter{...}` heading in an "index" file
   (`sections/04-results/04-results.tex`) and have it `\input` the parts:

   ```latex
   \chapter{...}
   \input{sections/04-results/01-setup}
   \input{sections/04-results/02-analysis}
   ```

3. Each part file (`01-setup.tex`, ...) just contains its `\section{...}` /
   `\subsection{...}` content — no `\chapter`.
4. Add the index file once in `main.tex`:
   `\input{sections/04-results/04-results}`.

> **Important:** `\input` paths are relative to **`main.tex`** (the project
> root), *not* to the file doing the including. So inside a folder, write the
> full path from the root: `\input{sections/04-results/01-setup}`.

You can keep simple sections as single files and split only the large ones —
mix freely.

### Writing prose: line breaks, paragraphs, and Git diffs

In LaTeX source, **a single line break is just a space** in the output, and a
**blank line starts a new paragraph**. So you do *not* have to keep a paragraph
on one giant line — break it across as many source lines as you like and the
compiled PDF is identical.

Recommended best practice for version control is **one sentence per line** (or
wrap at ~80–100 characters). LaTeX still joins them into one flowing paragraph,
but each sentence is its own line — so `git diff` highlights only the sentence
you changed instead of marking the whole paragraph as modified. The example
sections are written this way.

```latex
% This compiles to ONE paragraph, but stays readable and diff-friendly:
Üretken yapay zekânın yaygınlaşması eğitim alanında değişimlere yol açmıştır.
Ders hazırlığı ve içerik üretimi bu dönüşümün öne çıkan alanlarındandır.
Bu çalışma, söz konusu içerik üretimini ele almaktadır.

% A BLANK LINE here would start a new paragraph.
```

### Turkish characters

Type Turkish letters **directly** — `ı ç ö ğ ş ü İ Ş Ğ Ç Ö Ü` — they work as-is
(the template uses UTF-8 input with T1 fonts). You do **not** need LaTeX escape
forms like `\i` or `\c c`.

### Citations (MLA via biblatex)

Use biblatex commands — **not** Markdown/Pandoc `[@key]` syntax:

| You want | Command |
|---|---|
| Parenthetical | `\autocite{key}` → (Author 52) |
| With a page | `\autocite[52]{key}` |
| With a page range | `\autocite[pp.~52--57]{key}` (Turkish mode prints `ss.`) |
| Author in the sentence | `\textcite{key}` → Author (…) |
| Several works at once | `\autocites{a}{b}{c}` |

Add the corresponding entries to `references.bib`.

## Notes and known limitations

- **Cover format.** The covers follow the Institute of Graduate Studies' current
  official *DIŞ VE İÇ KAPAK / Outer and Inner Cover Pages* templates: the outer
  cover has no jury section, and the inner cover repeats the same content plus a
  *Jüri Üyeleri / Members of Examining Committee* list with a signature line per
  member. There is no separate approval page. (This supersedes the 2004 guide's
  cover layout.)
- **KVKK / personal data.** Do not put personal data in the thesis — no birth
  date, e-mail, phone number, or embedded signature images. The signature lines
  on the inner cover are left blank and signed physically after printing.
- The official guide (2004) predates the now-common **academic-integrity
  declaration**; it is included as a standard page. Comment out `\makedeclaration`
  in `main.tex` if your institute does not require it.
- `biblatex-mla` ships English strings only; `turkish-mla.lbx` adds the Turkish
  citation abbreviations from the guide (e.g. *Kaynakça*, *çev.*, *s./ss.*).
  Review citation output for your specific source types.
- Type titles, institute, department and programme **in the case you want them
  displayed**. The cover and headings respect Turkish casing (i ↔ İ) when the
  active language is Turkish.
- Physical-submission requirements (binding, copy counts, CDs) are out of scope;
  see the official guide.

## Contributing

Found something broken, outdated, or not matching the current İKÜ rules?
Contributions are very welcome:

1. **Open an issue** — describe the problem (with a screenshot or the relevant
   `.tex`/log snippet if you can) at
   <https://github.com/fatih-ml/iku-thesis-template-latex/issues>.
2. **Open a pull request** — fork the repo, make your fix on a branch, and open a
   PR against `main`. Please keep changes focused and explain what you changed and
   why. The maintainer reviews and merges PRs.
3. **Or just get in touch** — message **[@fatih-ml](https://github.com/fatih-ml)**
   on GitHub, or connect on
   **[LinkedIn](https://www.linkedin.com/in/fatih-calik-ml/)**.

Especially helpful: corrections to the official format (covers, Table of
Contents, abstracts), updated guide references, and Turkish localization fixes.

## License

Released under the **MIT License** (see [LICENSE](LICENSE)). The class file
(`iku-thesis.cls`) may alternatively be used under the LaTeX Project Public
License (LPPL) v1.3c or later.
