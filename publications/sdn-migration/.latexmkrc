$out_dir = 'dist';
$pdf_mode = 4;
$interaction = 'nonstopmode';
$synctex = 1;
$biber = "biber %O %B";

$jobname = 'sdn-migration';

$pdflatex = 'pdflatex -shell-escape %O %S';
$xelatex  = 'xelatex  -shell-escape %O %S';
$lualatex = 'lualatex -shell-escape %O %S';
