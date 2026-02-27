package main

import (
	"context"

	"dagger/public/internal/dagger"
	// "golang.org/x/sync/errgroup"
)

const (
	PageRelativePath = "pages"
)

type Blog struct {
	// Src is the source directory containing the blog
	Src *dagger.Directory
	// Directory containing templates for building the blog
	TemplateDir string
}

// BuildFile builds a single AsciiDoc page and returns the resulting HTML file.
func (m *Blog) BuildFile(
	ctx context.Context,
	// Page name to build
	pageName string,
) *dagger.File {
	container := m.prepareContainer(ctx)
	if pageName == "" {
		panic("pageName cannot be empty")
	}
	if len(pageName) < 5 || pageName[len(pageName)-5:] != ".adoc" {
		pageName += ".adoc"
	}
	return m.buildPage(ctx, container, m.Src.Directory(PageRelativePath).File(pageName))
}

// Build builds all AsciiDoc pages from the pages directory and returns a
// directory containing the HTML output along with CSS files from the template.
func (m *Blog) Build(
	ctx context.Context,
) *dagger.Directory {
	container := m.prepareContainer(ctx)

	output := dag.Directory().
		WithFile("aes.html", m.buildPage(ctx, container, m.Src.Directory(PageRelativePath).File("aes.adoc"))).
		WithFile("rsa.html", m.buildPage(ctx, container, m.Src.Directory(PageRelativePath).File("rsa.adoc"))).
		WithFile("side-channel.html", m.buildPage(ctx, container, m.Src.Directory(PageRelativePath).File("side-channel.adoc")))

	// Include CSS files from the template directory
	output = output.WithDirectory(".", m.Src.Directory(m.TemplateDir), dagger.DirectoryWithDirectoryOpts{
		Include: []string{"*.css"},
	})

	return output
}

// --- Helper functions ---
func (m *Blog) prepareContainer(ctx context.Context) *dagger.Container {
	return dag.Container().
		From("alpine:3").
		WithExec([]string{"apk", "add", "--no-cache", "ruby", "ruby-dev", "build-base"}).
		WithExec([]string{"gem", "install", "tilt", "asciidoctor", "concurrent-ruby", "--no-document"}).
		WithExec([]string{"mkdir", "/src"}).
		WithWorkdir("/src")
}

func (m *Blog) buildPage(
	ctx context.Context,
	container *dagger.Container,
	file *dagger.File,
) *dagger.File {
	return container.
		WithFile("source.adoc", file).
		WithDirectory("./template", m.Src.Directory(m.TemplateDir)).
		WithExec([]string{"asciidoctor", "-T", "template/", "-o", "out.html", "source.adoc"}).
		File("out.html")
}
