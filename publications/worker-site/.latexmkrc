$out_dir = 'dist';
$pdf_mode = 4;
$interaction = 'nonstopmode';
$synctex = 1;
$biber = "biber --input-directory=$out_dir --output-directory=$out_dir %O %B";

$jobname = 'worker-site';

$pdflatex = 'pdflatex -shell-escape %O %S';
$xelatex  = 'xelatex  -shell-escape %O %S';
$lualatex = 'lualatex -shell-escape %O %S';
