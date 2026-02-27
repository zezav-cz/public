package main

import (
	"context"

	"dagger/public/internal/dagger"
)

type Publication string

const (
	AFAPLE                  Publication = "as-far-as-possible-le"
	BT                      Publication = "batchelor-thesis"
	BTP                     Publication = "batchelor-thesis-prez"
	BTC                     Publication = "batchelor-thesis-cover"
	DT                      Publication = "diploma-thesis"
	CvEn                    Publication = "cv-en"
	CvCz                    Publication = "cv-cz"
	DistributedStorage      Publication = "distributed-storage-solutions"
	MergeSort               Publication = "merge-sort"
	Normality               Publication = "normality"
	SdnMigration            Publication = "sdn-migration"
	WindowsReverseRdpAttack Publication = "windows-reverse-rdp-attack"
	WorkerSite              Publication = "worker-site"
)

type Publications struct {
	Src *dagger.Directory
}

// BuildAll builds all publications in parallel and returns a directory with all PDFs
func (m *Publications) Build(
	ctx context.Context,
) *dagger.Directory {
	// Call dagger call build-all export --path dist/
	return dag.Directory().
		WithFile("afap-le.pdf", m.BuildPublication(ctx, AFAPLE)).
		WithFile("cv-en.pdf", m.BuildPublication(ctx, CvEn)).
		WithFile("cv-cz.pdf", m.BuildPublication(ctx, CvCz)).
		WithFile("distributed-storage.pdf", m.BuildPublication(ctx, DistributedStorage)).
		WithFile("normality.pdf", m.BuildPublication(ctx, Normality)).
		WithFile("merge-sort.pdf", m.BuildPublication(ctx, MergeSort)).
		WithFile("sdn-migration.pdf", m.BuildPublication(ctx, SdnMigration)).
		WithFile("windows-reverse-rdp-attack.pdf", m.BuildPublication(ctx, WindowsReverseRdpAttack)).
		WithFile("worker-site.pdf", m.BuildPublication(ctx, WorkerSite)).
		WithFile("batchelor-thesis.pdf", m.BuildPublication(ctx, BT)).
		WithFile("batchelor-thesis-defence.pdf", m.BuildPublication(ctx, BTP)).
		WithFile("batchelor-thesis-cover.pdf", m.BuildPublication(ctx, BTC)).
		WithFile("diploma-thesis.pdf", m.BuildPublication(ctx, DT))
}

// BuildPublication builds a single publication based on the given Publication type
func (m *Publications) BuildPublication(
	ctx context.Context,
	pub Publication,
) *dagger.File {
	switch pub {
	case AFAPLE:
		return m.buildTypst(m.Src.Directory((string(AFAPLE))), "main.typ")
	case BT:
		return m.buildBatchelorThesis(m.Src.Directory("batchelor-thesis"), "trojaj12-bachelor-thesis.tex", "thesis")
	case BTP:
		return m.buildBatchelorThesis(m.Src.Directory("batchelor-thesis"), "defence.tex", "defence")
	case BTC:
		return m.buildBatchelorThesis(m.Src.Directory("batchelor-thesis"), "cover.tex", "cover")
	case DT:
		return m.buildDiplomaThesis(m.Src.Directory(string(DT)))
	case CvEn:
		return m.buildTypst(m.Src.Directory((string("cv"))), "main-en.typ")
	case CvCz:
		return m.buildTypst(m.Src.Directory((string("cv"))), "main-cz.typ")
	case DistributedStorage:
		return m.buildTypst(m.Src.Directory((string(DistributedStorage))), "main.typ")
	case MergeSort:
		return m.buildTypst(m.Src.Directory((string(MergeSort))), "main.typ")
	case Normality:
		return m.buildTypst(m.Src.Directory((string(Normality))), "main.typ")
	case SdnMigration:
		return m.buildLatex(m.Src.Directory((string(SdnMigration))), "main.tex")
	case WindowsReverseRdpAttack:
		return m.buildLatex(m.Src.Directory((string(WindowsReverseRdpAttack))), "main.tex")
	case WorkerSite:
		return m.buildLatex(m.Src.Directory((string(WorkerSite))), "main.tex")
	default:
		panic("unknown publication: " + string(pub))
	}
}

// --- Helper functions ---

func (m *Publications) buildTypst(source *dagger.Directory, mainFile string) *dagger.File {
	return dag.Container().
		From("ghcr.io/typst/typst:latest").
		WithDirectory("/src", source).
		WithWorkdir("/src").
		WithExec([]string{"typst", "compile", mainFile, "/output.pdf"}).
		File("/output.pdf")
}

func (m *Publications) buildBatchelorThesis(source *dagger.Directory, mainFile string, directory string) *dagger.File {
	return dag.Container().
		From("texlive/texlive:latest").
		WithDirectory("/src", source).
		WithWorkdir("/src/" + directory).
		WithExec([]string{"latexmk", "-pdf", "-outdir=.", "-jobname=text", "-interaction=nonstopmode", mainFile}).
		File("/src/" + directory + "/text.pdf")
}

func (m *Publications) buildLatex(source *dagger.Directory, mainFile string) *dagger.File {
	// texlive/texlive is Debian-based
	return dag.Container().
		From("texlive/texlive:latest").
		WithDirectory("/src", source).
		WithWorkdir("/src").
		WithExec([]string{"latexmk", "-pdf", "-outdir=.", "-jobname=text", "-interaction=nonstopmode", mainFile}).
		File("/src/text.pdf")
}

// buildDiplomaThesis builds the diploma thesis using settings from its .latexmkrc
// (pdf_mode=5 → XeLaTeX, out_dir=dist)
func (m *Publications) buildDiplomaThesis(source *dagger.Directory) *dagger.File {
	return dag.Container().
		From("texlive/texlive:latest").
		WithDirectory("/src", source).
		WithWorkdir("/src").
		WithExec([]string{"latexmk", "-jobname=text", "-interaction=nonstopmode", "main.tex"}).
		File("/src/dist/text.pdf")
}
