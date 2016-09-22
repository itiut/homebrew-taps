require "language/go"

class GitGitlab < Formula
  desc "Git CLI support for GitLab"
  homepage "https://github.com/numa08/git-gitlab"
  url "https://github.com/numa08/git-gitlab/archive/f951d0528838aad99f768d504b36b03194daa72e.tar.gz"
  version "0.1.0"
  sha256 "83a902f6aa3f9b42af5e3aae557f6a9de0e6ca49873d2f118712aac952409d5f"

  depends_on "libgit2"
  depends_on "go" => :build
  depends_on "pkg-config" => :build

  go_resource "gopkg.in/libgit2/git2go.v24" do
    url "https://gopkg.in/libgit2/git2go.v24.git",
      :revision => "241aa34d83b210ceaab7029c46e05794f2ea9797"
  end

  go_resource "github.com/plouc/go-gitlab-client" do
    url "https://github.com/plouc/go-gitlab-client.git",
      :revision => "97509738052118879f30ea4243998228468d3a2b"
  end

  go_resource "github.com/codegangsta/cli" do
    url "https://github.com/codegangsta/cli.git",
      :revision => "d53eb991652b1d438abdd34ce4bfa3ef1539108e"
  end

  def install
    ENV["GOBIN"] = bin
    ENV["GOPATH"] = buildpath
    ENV["GOHOME"] = buildpath

    mkdir_p buildpath/"src/github.com/numa08/"
    ln_sf buildpath, buildpath/"src/github.com/numa08/git-gitlab"
    Language::Go.stage_deps resources, buildpath/"src"

    system "go", "build", "-o", bin/"git-lab"
    man1.install "man/git-lab.1"
  end

  test do
    system bin/"git-lab", "-h"
  end
end
