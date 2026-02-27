package main

import (
	"dagger/public/internal/dagger"
)

type Web string

const (
	Pub  Web = "pub.zezav.cz"
	Main Web = "zezav.cz"
)

type Pages struct {
	// Src is the source directory containing the pages
	Src *dagger.Directory
}

// Builds the publications site
func (m *Pages) BuildPubSite() *dagger.Directory {
	return m.Src.Directory(string(Pub))
}

// Builds the main site
func (m *Pages) BuildMainSite() *dagger.Directory {
	return m.Src.Directory(string(Main))
}
