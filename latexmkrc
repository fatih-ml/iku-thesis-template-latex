# latexmk configuration for the IKU thesis template.
# Build with: latexmk -pdf main.tex   (Overleaf uses this automatically)
$pdf_mode = 1;          # produce PDF via pdflatex
$bibtex_use = 2;        # run the bibliography tool as needed
$biber = 'biber %O %S'; # biblatex uses biber as the backend

# Files produced by biblatex/biber that latexmk should also clean with -c/-C.
push @generated_exts, 'bbl', 'run.xml', 'bcf';
$clean_ext .= ' %R.synctex.gz';
