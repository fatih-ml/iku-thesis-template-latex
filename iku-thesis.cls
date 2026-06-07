%% iku-thesis.cls
%% LaTeX document class for Istanbul Kultur University (IKU) graduate theses.
%%
%% Author:  Fatih Çalık  (github.com/fatih-ml)
%% Repo:    https://github.com/fatih-ml/iku-thesis-template-latex
%% License: MIT (see LICENSE). A community gift to IKU students.
%%
%% Implements the formatting rules of the IKU "Thesis Writing Guide" (Sept 2004):
%%   - A4 paper, margins left 4cm / right-top-bottom 2.5cm
%%   - Times New Roman 12pt body (via newtx), 1.5 line spacing
%%   - Roman page numbers for front matter, Arabic for the main body
%%   - Heading hierarchy and spacing per the guide
%%   - Mandatory bilingual abstracts (Turkish OZ + foreign-language ABSTRACT)
%%
%% Bilingual: pass the option `turkish` (default) or `english`. The flag switches
%% babel's main language and every fixed string; both abstracts are always printed.
%%
%% Degree: `ms` (default), `phd`, or `arts` (proficiency-in-art).
%%
%% Engine: pdfLaTeX. Bibliography: biblatex (MLA) + biber.
%%
%% This file is part of the IKU thesis template and is released under the MIT
%% License (see LICENSE). You may alternatively redistribute/modify it under the
%% terms of the LaTeX Project Public License (LPPL) v1.3c or later.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iku-thesis}[2026/06/07 v1.0 Istanbul Kultur University thesis class]

% --------------------------------------------------------------------------
%  Options
% --------------------------------------------------------------------------
% Language: turkish (default) | english
\newif\ifiku@turkish \iku@turkishtrue
\DeclareOption{turkish}{\iku@turkishtrue}
\DeclareOption{english}{\iku@turkishfalse}

% Degree: ms (default) | phd | arts
\newif\ifiku@phd  \iku@phdfalse
\newif\ifiku@arts \iku@artsfalse
\DeclareOption{ms}{\iku@phdfalse\iku@artsfalse}
\DeclareOption{phd}{\iku@phdtrue\iku@artsfalse}
\DeclareOption{arts}{\iku@phdfalse\iku@artstrue}

% Anything else is passed to the base class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions{turkish,ms}
\ProcessOptions\relax

\LoadClass[a4paper,12pt,oneside,openany]{report}

% --------------------------------------------------------------------------
%  Core packages
% --------------------------------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
% Times New Roman clone for text and math.
\RequirePackage{newtxtext}
\RequirePackage{newtxmath}
% Use Latin Modern Mono for \texttt: it is available in every TeX distribution
% (including minimal installs), unlike newtx's own mono font which some setups
% lack. It pairs cleanly with Times.
\renewcommand{\ttdefault}{lmtt}

% Languages: load both; the main language is selected from the class option.
\ifiku@turkish
  \RequirePackage[english,main=turkish]{babel}
\else
  \RequirePackage[turkish,main=english]{babel}
\fi

\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{graphicx}
\RequirePackage{amsmath}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{array}
\RequirePackage{titlesec}
\RequirePackage{tocloft}
\RequirePackage[font=small,labelsep=period]{caption}
\RequirePackage{enumitem}
\RequirePackage{calc}
\RequirePackage[hidelinks]{hyperref}

% Turkish babel makes "=" an active shorthand, which breaks key=value options in
% packages such as enumitem (e.g. \begin{enumerate}[leftmargin=1.5em]). Turn the
% shorthand off so those options parse normally.
\ifiku@turkish \AtBeginDocument{\shorthandoff{=}}\fi

% --------------------------------------------------------------------------
%  Bibliography: MLA via biblatex + biber
% --------------------------------------------------------------------------
% autostyle=false keeps MLA's double quotation marks for titles regardless of
% the document language (MLA is an English-convention style; this also avoids
% missing-glyph output for language-specific quote characters).
\RequirePackage[autostyle=false]{csquotes}
\RequirePackage[style=mla,backend=biber]{biblatex}
% In Turkish mode, map the Turkish locale to our shipped MLA localization so
% citation acronyms follow the guide (Kaynakca, cev., s./ss., Ed./Haz., ...).
\ifiku@turkish
  \DeclareLanguageMapping{turkish}{turkish-mla}
\fi

% --------------------------------------------------------------------------
%  Page geometry (Guide section 3.4): A4, left 4cm, others 2.5cm.
%  footskip keeps the centered page number within the 2.5cm bottom margin.
% --------------------------------------------------------------------------
\geometry{a4paper,left=4cm,right=2.5cm,top=2.5cm,bottom=2.5cm,footskip=1cm}

% --------------------------------------------------------------------------
%  Line spacing (Guide section 3.5): 1.5 for body text.
%  Lists, abstracts, captions and footnotes use single spacing.
% --------------------------------------------------------------------------
\onehalfspacing
\captionsetup{font={small,singlespacing}}
% Single-spaced footnotes.
\let\iku@oldfootnote\footnote
\AtBeginDocument{\setlength{\footnotesep}{0.8\baselineskip}}

% Indent the first paragraph after a heading too (common thesis convention).
\RequirePackage{indentfirst}

% --------------------------------------------------------------------------
%  Bilingual fixed strings.
%  \bilingual{<turkish>}{<english>} expands to the right one for the active language.
% --------------------------------------------------------------------------
\ifiku@turkish
  \newcommand{\bilingual}[2]{#1}
\else
  \newcommand{\bilingual}[2]{#2}
\fi

\newcommand{\iku@univ}{\bilingual{T.C.\\ İSTANBUL KÜLTÜR ÜNİVERSİTESİ}%
                            {T.C.\\ İSTANBUL KÜLTÜR UNIVERSITY}}
\newcommand{\iku@contents}{\bilingual{İÇİNDEKİLER}{TABLE OF CONTENTS}}
\newcommand{\iku@lot}{\bilingual{TABLO LİSTESİ}{LIST OF TABLES}}
\newcommand{\iku@lof}{\bilingual{ŞEKİL LİSTESİ}{LIST OF FIGURES}}
\newcommand{\iku@los}{\bilingual{SİMGE LİSTESİ}{LIST OF SYMBOLS}}
\newcommand{\iku@abbr}{\bilingual{KISALTMALAR}{ABBREVIATIONS}}
\newcommand{\iku@preface}{\bilingual{ÖNSÖZ}{PREFACE}}
\newcommand{\iku@oztitle}{\bilingual{ÖZ}{ÖZ}}
\newcommand{\iku@abstracttitle}{ABSTRACT}
\newcommand{\iku@keywords}{\bilingual{Anahtar Kelimeler}{Keywords}}
\newcommand{\iku@biblabel}{\bilingual{KAYNAKÇA}{BIBLIOGRAPHY}}
\newcommand{\iku@tablename}{\bilingual{Tablo}{Table}}
\newcommand{\iku@figurename}{\bilingual{Şekil}{Figure}}
\newcommand{\iku@advisorlbl}{\bilingual{Tez Danışmanı}{Supervisor}}
\newcommand{\iku@coadvisorlbl}{\bilingual{İkinci Danışman}{Co-Advisor}}
\newcommand{\iku@studentnolbl}{\bilingual{Öğrenci No}{Student Number}}
\newcommand{\iku@departmentlbl}{\bilingual{Anabilim Dalı}{Department}}
\newcommand{\iku@programlbl}{\bilingual{Program}{Program}}
\newcommand{\iku@directorlbl}{\bilingual{Enstitü Müdürü}{Director of the Institute}}
\newcommand{\iku@datesubmittedlbl}{\bilingual{Tezin Enstitüye Verildiği Tarih}{Date of Submission}}
\newcommand{\iku@datedefendedlbl}{\bilingual{Tezin Savunulduğu Tarih}{Date of Defense}}
\newcommand{\iku@jurytitle}{\bilingual{JÜRİ ONAYI}{APPROVAL OF THE JURY}}
\newcommand{\iku@jurymemberslbl}{\bilingual{Jüri Üyeleri}{Members of Examining Committee}}
\newcommand{\iku@declarationtitle}{\bilingual{ETİK İLKELERE UYGUNLUK BEYANI}%
                                          {DECLARATION OF ACADEMIC INTEGRITY}}

% Degree wording.
\ifiku@phd
  \newcommand{\iku@degree}{\bilingual{DOKTORA TEZİ}{DOCTORAL THESIS}}
\else\ifiku@arts
  \newcommand{\iku@degree}{\bilingual{SANATTA YETERLİK TEZİ}{PROFICIENCY-IN-ART THESIS}}
\else
  \newcommand{\iku@degree}{\bilingual{YÜKSEK LİSANS TEZİ}{MASTER'S THESIS}}
\fi\fi

% --------------------------------------------------------------------------
%  Metadata setters (used in metadata.tex).
% --------------------------------------------------------------------------
\newcommand{\@titleTR}{}   \newcommand{\titleTR}[1]{\renewcommand{\@titleTR}{#1}}
\newcommand{\@titleEN}{}   \newcommand{\titleEN}[1]{\renewcommand{\@titleEN}{#1}}
\newcommand{\@thesisauthor}{} \newcommand{\thesisauthor}[1]{\renewcommand{\@thesisauthor}{#1}}
\newcommand{\@studentno}{}  \newcommand{\studentno}[1]{\renewcommand{\@studentno}{#1}}
\newcommand{\@instituteTR}{} \newcommand{\instituteTR}[1]{\renewcommand{\@instituteTR}{#1}}
\newcommand{\@instituteEN}{} \newcommand{\instituteEN}[1]{\renewcommand{\@instituteEN}{#1}}
\newcommand{\@departmentTR}{} \newcommand{\departmentTR}[1]{\renewcommand{\@departmentTR}{#1}}
\newcommand{\@departmentEN}{} \newcommand{\departmentEN}[1]{\renewcommand{\@departmentEN}{#1}}
\newcommand{\@programTR}{}  \newcommand{\programTR}[1]{\renewcommand{\@programTR}{#1}}
\newcommand{\@programEN}{}  \newcommand{\programEN}[1]{\renewcommand{\@programEN}{#1}}
\newcommand{\@advisor}{}    \newcommand{\advisor}[1]{\renewcommand{\@advisor}{#1}}
\newcommand{\@coadvisor}{}  \newcommand{\coadvisor}[1]{\renewcommand{\@coadvisor}{#1}}
\newcommand{\@director}{}   \newcommand{\director}[1]{\renewcommand{\@director}{#1}}
\newcommand{\@submissiondate}{} \newcommand{\submissiondate}[1]{\renewcommand{\@submissiondate}{#1}}
\newcommand{\@defensedate}{} \newcommand{\defensedate}[1]{\renewcommand{\@defensedate}{#1}}
\newcommand{\@coverdate}{}  \newcommand{\coverdate}[1]{\renewcommand{\@coverdate}{#1}}
\newcommand{\@keywordsTR}{} \newcommand{\keywordsTR}[1]{\renewcommand{\@keywordsTR}{#1}}
\newcommand{\@keywordsEN}{} \newcommand{\keywordsEN}[1]{\renewcommand{\@keywordsEN}{#1}}
\newcommand{\@city}{}       \newcommand{\city}[1]{\renewcommand{\@city}{#1}}
\newcommand{\@thesisyear}{} \newcommand{\thesisyear}[1]{\renewcommand{\@thesisyear}{#1}}

% Jury members: \jurymember[1..5]. Empty ones are skipped.
\newcommand{\@juryA}{} \newcommand{\@juryB}{} \newcommand{\@juryC}{}
\newcommand{\@juryD}{} \newcommand{\@juryE}{}
\newcommand{\juryA}[1]{\renewcommand{\@juryA}{#1}}
\newcommand{\juryB}[1]{\renewcommand{\@juryB}{#1}}
\newcommand{\juryC}[1]{\renewcommand{\@juryC}{#1}}
\newcommand{\juryD}[1]{\renewcommand{\@juryD}{#1}}
\newcommand{\juryE}[1]{\renewcommand{\@juryE}{#1}}

% Language-aware accessors for the title / department / program / institute.
\newcommand{\iku@title}{\bilingual{\@titleTR}{\@titleEN}}
\newcommand{\iku@institute}{\bilingual{\@instituteTR}{\@instituteEN}}
\newcommand{\iku@department}{\bilingual{\@departmentTR}{\@departmentEN}}
\newcommand{\iku@program}{\bilingual{\@programTR}{\@programEN}}

% --------------------------------------------------------------------------
%  Headings (Guide sections 3.4 and 3.5).
%  Level 1 (\chapter): UPPERCASE bold, no "Chapter" word, starts ~5cm from the
%    top edge (2.5cm top margin + ~71pt). 18pt after.
%  Level 2 (\section): lowercase bold, 18pt before / 12pt after.
%  Level 3 (\subsection): lowercase plain, 12pt before / 6pt after.
%  Level 4 (\subsubsection): body font, 12pt before / 6pt after.
% --------------------------------------------------------------------------
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{4}

% [block] runs the format code in vertical mode, so the leading \vspace* is NOT
% discarded at the top of a page -- this places the L1 title ~5cm from the top
% edge (2.5cm top margin + 2.5cm), as the guide requires, for every chapter.
\titleformat{\chapter}[block]
  {\vspace*{2.5cm}\normalfont\bfseries}
  {\thechapter.}{1ex}{\MakeUppercase}
\titlespacing*{\chapter}{0pt}{0pt}{18pt}

\titleformat{\section}[hang]
  {\normalfont\bfseries}
  {\thesection.}{1ex}{}
\titlespacing*{\section}{0pt}{18pt}{12pt}

\titleformat{\subsection}[hang]
  {\normalfont}
  {\thesubsection.}{1ex}{}
\titlespacing*{\subsection}{0pt}{12pt}{6pt}

\titleformat{\subsubsection}[hang]
  {\normalfont}
  {\thesubsubsection.}{1ex}{}
\titlespacing*{\subsubsection}{0pt}{12pt}{6pt}

% Number tables, figures and equations within the top-level section (chapter).
\renewcommand{\thefigure}{\thechapter.\arabic{figure}}
\renewcommand{\thetable}{\thechapter.\arabic{table}}
\renewcommand{\theequation}{\thechapter.\arabic{equation}}
\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}
\counterwithin{equation}{chapter}

% Caption labels follow the active language ("Tablo 1.2" / "Table 1.2").
\addto\captionsturkish{%
  \renewcommand{\tablename}{\iku@tablename}%
  \renewcommand{\figurename}{\iku@figurename}}
\addto\captionsenglish{%
  \renewcommand{\tablename}{\iku@tablename}%
  \renewcommand{\figurename}{\iku@figurename}}

% --------------------------------------------------------------------------
%  Table of contents / lists styling (tocloft): 1.5 spacing handled globally;
%  primary entries bold per the guide's sample (Appendix H).
% --------------------------------------------------------------------------
\renewcommand{\contentsname}{\iku@contents}
\renewcommand{\listtablename}{\iku@lot}
\renewcommand{\listfigurename}{\iku@lof}
\renewcommand{\bibname}{\iku@biblabel}

% Show chapter entries in bold in the ToC, with page numbers (no leaders look
% matching the guide samples).
\renewcommand{\cftchapfont}{\bfseries}
\renewcommand{\cftchappagefont}{\bfseries}
\renewcommand{\cftchapleader}{\bfseries\cftdotfill{\cftdotsep}}
\setlength{\cftbeforechapskip}{6pt}

% Title used at the top of every front-matter list page.
\newcommand{\iku@listhead}[1]{%
  \chapter*{#1}%
  \addcontentsline{toc}{chapter}{#1}}

% --------------------------------------------------------------------------
%  Page styles / pagination (Guide section 3.6): page number centered at the
%  bottom. report's "plain" style already centers the number at the bottom.
% --------------------------------------------------------------------------
\pagestyle{plain}

% Front matter: roman numerals. The preface is page "i" but not printed.
\newcommand{\frontmatterstyle}{\pagenumbering{roman}\pagestyle{plain}}
\newcommand{\mainmatterstyle}{\clearpage\pagenumbering{arabic}\pagestyle{plain}}

% --------------------------------------------------------------------------
%  Cover pages -- following the current official "DIŞ VE İÇ KAPAK" / "Outer and
%  Inner Cover Pages" format provided by the Institute of Graduate Studies.
%
%  Outer cover (dış / birinci kapak): university block, title, degree, author,
%    student number, department, programme, advisor, month+year.
%  Inner cover (iç / ikinci kapak): IDENTICAL content PLUS a "Jüri Üyeleri" /
%    "Members of Examining Committee" section with a signature line per member.
%  There is no separate approval page; the jury section lives on the inner cover.
%  No logo (not part of the official format). No personal data beyond what the
%  format requires (KVKK): no birth date, e-mail, phone, or embedded signatures.
% --------------------------------------------------------------------------

% One jury member: name followed by a dotted signature line (left blank in the
% PDF; signed physically after printing).
\newcommand{\iku@coverjuryline}[1]{%
  #1~\dotfill\null\par\vspace{0.7cm}}

% The jury section printed on the inner cover only.
\newcommand{\iku@coverjury}{%
  \par\vspace{1.0cm}%
  \begin{minipage}{0.82\textwidth}%
    \raggedright\normalfont
    \iku@jurymemberslbl:\par\vspace{0.6cm}%
    \ifx\@juryA\@empty\else\iku@coverjuryline{\@juryA}\fi
    \ifx\@juryB\@empty\else\iku@coverjuryline{\@juryB}\fi
    \ifx\@juryC\@empty\else\iku@coverjuryline{\@juryC}\fi
    \ifx\@juryD\@empty\else\iku@coverjuryline{\@juryD}\fi
    \ifx\@juryE\@empty\else\iku@coverjuryline{\@juryE}\fi
  \end{minipage}\par}

% Shared cover body. #1 = 1 -> inner cover (adds the jury section); 0 -> outer.
\newcommand{\iku@covercontent}[1]{%
  \begin{titlepage}%
  \thispagestyle{empty}%
  \centering\singlespacing
  % University + institute header.
  {\bfseries\iku@univ\\[4pt]\MakeUppercase{\iku@institute}\par}%
  \vspace{2.4cm}%
  % Thesis title.
  {\bfseries\large\MakeUppercase{\iku@title}\par}%
  \vspace{1.8cm}%
  % Degree.
  {\bfseries\iku@degree\par}%
  \vspace{1.6cm}%
  % Author + student number (no labels, per the official format).
  {\@thesisauthor\par \@studentno\par}%
  \vspace{1.4cm}%
  % Department + programme (with labels).
  {\iku@departmentlbl: \iku@department\par
   \iku@programlbl: \iku@program\par}%
  \vspace{1.2cm}%
  % Advisor(s).
  {\iku@advisorlbl: \@advisor\par
   \ifx\@coadvisor\@empty\else\iku@coadvisorlbl: \@coadvisor\par\fi}%
  % Inner cover only: jury members with signature lines.
  \ifnum#1=1 \iku@coverjury \fi
  \vfill
  % Month + year.
  {\@coverdate\par}%
  \end{titlepage}%
}

% Outer cover (dış kapak) -- in the thesis language.
\newcommand{\makecover}{\iku@covercontent{0}}

% Inner cover (iç kapak) -- same content + jury signature section.
\newcommand{\makeinnercover}{\iku@covercontent{1}}

% Turkish inner cover for foreign-language theses: an additional Turkish-language
% inner cover (with the jury section) that follows the foreign-language covers.
\newcommand{\maketurkishinnercover}{%
  \begingroup
  \renewcommand{\bilingual}[2]{##1}% force Turkish strings
  % Switch to Turkish so \MakeUppercase casing (i->I, i->İ) is correct.
  \begin{otherlanguage}{turkish}\iku@covercontent{1}\end{otherlanguage}%
  \endgroup
}

% --------------------------------------------------------------------------
%  Declaration of academic integrity (modern requirement; see README note).
%  Body text is passed as the argument.
% --------------------------------------------------------------------------
\newcommand{\makedeclaration}[1]{%
  \clearpage
  \iku@listhead{\iku@declarationtitle}%
  #1\par
  \vspace{2\baselineskip}%
  \hfill\@thesisauthor\par
}

% --------------------------------------------------------------------------
%  Preface / Onsoz (Guide section 4.2.1). Body passed as argument; author is
%  right-aligned and the date left-aligned at the end (per the guide).
% --------------------------------------------------------------------------
\newcommand{\makepreface}[1]{%
  \iku@listhead{\iku@preface}%
  #1\par
  \vspace{2\baselineskip}%
  \noindent\@coverdate\hfill\@thesisauthor\par
}

% --------------------------------------------------------------------------
%  Abstracts (Guide section 4.2.4). Both are always printed. Each shows a
%  metadata header, the thesis title, the body, then the keywords.
% --------------------------------------------------------------------------
\newcommand{\iku@abstractheader}[3]{%
  % #1 institute, #2 department, #3 program
  \singlespacing
  \noindent\begin{tabular}{@{}ll@{}}%
    \bilingual{Üniversite}{University} & : İstanbul Kültür \bilingual{Üniversitesi}{University}\\
    \bilingual{Enstitü}{Institute} & : #1\\
    \bilingual{Anabilim Dalı}{Department} & : #2\\
    \bilingual{Program}{Programme} & : #3\\
    \iku@advisorlbl & : \@advisor\\
    \bilingual{Tez Türü ve Tarihi}{Degree and Date} & : \iku@degree, \@thesisyear\\
  \end{tabular}\par
  \vspace{1\baselineskip}%
  \onehalfspacing
}

% Turkish abstract (OZ). #1 = body text.
\newcommand{\makeoz}[1]{%
  \clearpage
  \chapter*{\iku@oztitle}\addcontentsline{toc}{chapter}{\iku@oztitle}%
  \begingroup\renewcommand{\bilingual}[2]{##1}%
  \begin{otherlanguage}{turkish}% correct Turkish hyphenation/casing
  \iku@abstractheader{\@instituteTR}{\@departmentTR}{\@programTR}%
  \begin{center}\bfseries\@titleTR\par\end{center}%
  \vspace{0.5\baselineskip}%
  #1\par
  \vspace{1\baselineskip}%
  \noindent\textbf{Anahtar Kelimeler:} \@keywordsTR\par
  \end{otherlanguage}%
  \endgroup
}

% Foreign-language abstract (ABSTRACT). #1 = body text.
\newcommand{\makeabstract}[1]{%
  \clearpage
  \chapter*{\iku@abstracttitle}\addcontentsline{toc}{chapter}{\iku@abstracttitle}%
  \begingroup\renewcommand{\bilingual}[2]{##2}%
  \begin{otherlanguage}{english}% correct English hyphenation
  \iku@abstractheader{\@instituteEN}{\@departmentEN}{\@programEN}%
  \begin{center}\bfseries\@titleEN\par\end{center}%
  \vspace{0.5\baselineskip}%
  #1\par
  \vspace{1\baselineskip}%
  \noindent\textbf{Keywords:} \@keywordsEN\par
  \end{otherlanguage}%
  \endgroup
}

% --------------------------------------------------------------------------
%  Front-matter list helpers.
% --------------------------------------------------------------------------
% Table of contents. We print the title via \chapter* (so it matches every other
% primary heading) and read the .toc file directly, bypassing tocloft's large,
% title-case heading. tocloft still styles the entries (bold chapters + leaders).
\newcommand{\maketableofcontents}{%
  \chapter*{\iku@contents}\@starttoc{toc}}

% Abbreviations and List of Symbols use a description-like two-column layout.
% Provide an environment the user fills with \abbr{KEY}{meaning}.
\newcommand{\abbr}[2]{\noindent\makebox[3cm][l]{#1}: #2\par}
\newcommand{\makeabbreviations}[1]{%
  \iku@listhead{\iku@abbr}%
  \singlespacing #1 \onehalfspacing}
\newcommand{\makelistofsymbols}[1]{%
  \iku@listhead{\iku@los}%
  \singlespacing #1 \onehalfspacing}

% List of tables / figures: same treatment as the ToC -- \chapter* heading
% (consistent style + own page + bookmark), a ToC entry, then the list body.
% These are NEW commands (not \renewcommand of \listof*) so that hyperref and
% tocloft cannot override them at \begin{document}.
\newcommand{\makelistoftables}{%
  \chapter*{\iku@lot}\addcontentsline{toc}{chapter}{\iku@lot}\@starttoc{lot}}
\newcommand{\makelistoffigures}{%
  \chapter*{\iku@lof}\addcontentsline{toc}{chapter}{\iku@lof}\@starttoc{lof}}

% --------------------------------------------------------------------------
%  Bibliography helper: prints the references with a heading + ToC entry.
% --------------------------------------------------------------------------
\newcommand{\makebibliography}{%
  \clearpage
  \printbibliography[heading=bibintoc,title={\iku@biblabel}]}

% Convenience: include a table float stored under tables/.
\newcommand{\inputtable}[1]{\input{tables/#1}}
% Convenience: include a figure (PDF) stored under figures/ as a float.
\newcommand{\iku@figurefloat}[4][htbp]{% [placement]{file}{caption}{label}
  \begin{figure}[#1]\centering
    \includegraphics[width=0.8\textwidth]{figures/#2}
    \caption{#3}\label{#4}
  \end{figure}}
\let\thesisfigure\iku@figurefloat

\endinput
