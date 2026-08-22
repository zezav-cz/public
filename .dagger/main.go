package main

import (
	"context"
	"fmt"
	"time"

	"dagger/public/internal/dagger"
)

type Public struct {
	// Pub contains functions for building various publications (PDFs)
	Pub *Publications
	// Blog contains functions for building the blog (HTML files)
	Blog *Blog
	// Pages contains functions for building the pages (HTML files)
	Pages *Pages
}

func New(
	// +defaultPath="/publications"
	srcPublications *dagger.Directory,
	// +defaultPath="/blog"
	srcBlog *dagger.Directory,
	// +defaultPath="/pages"
	srcPages *dagger.Directory,
) *Public {
	return &Public{
		Pub:   &Publications{Src: srcPublications},
		Blog:  &Blog{Src: srcBlog, TemplateDir: "template"},
		Pages: &Pages{Src: srcPages},
	}
}

// Publish uploads the artifacts to a server via rsync
func (m *Public) Publish(
	ctx context.Context,
	// artifacts to be published
	artifacts *dagger.Directory,
	// Server to which the artifacts should be published (e.g. "example.com")
	server string,
	// User to use for SSH
	// +default="uploader"
	user string,
	// Destination path on the server
	destPath string,
	// SSH key to use for authentication
	sshKey *dagger.Secret,
) (string, error) {
	// Setup SSH
	ctr := dag.Container().
		From("alpine:latest").
		WithExec([]string{"apk", "add", "--no-cache", "rsync", "openssh-client"}).
		WithMountedSecret("/id_pubkey", sshKey).
		WithNewFile("/root/.ssh/config", "StrictHostKeyChecking no\n")
	// Rsync
	return ctr.
		WithMountedDirectory("/tmp/artifacts", artifacts).
		// Publishing is a side effect — bust Dagger's cache so rsync runs on every call
		WithEnvVariable("CACHEBUSTER", time.Now().String()).
		WithExec([]string{
			"sh", "-c",
			// --perms is required for --chmod to take effect on the receiver
			fmt.Sprintf("rsync -rpvztL --chmod=D755,F644 --chown=uploader:www-data -e 'ssh -i /id_pubkey' /tmp/artifacts/ %s@%s:%s", user, server, destPath),
		}).
		Stdout(ctx)
}
