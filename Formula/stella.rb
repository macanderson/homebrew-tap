# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.21 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-tap) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.6.21"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.21/stella-0.6.21-aarch64-apple-darwin.tar.gz"
      sha256 "5591e19a32e55120e8f6e106f52d3ccbfdefdf56a975cd46ee96aba10126f5ad"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.21/stella-0.6.21-x86_64-apple-darwin.tar.gz"
      sha256 "86054956801c2dce7c16796a52c704db799f2e90028c715b378ab22625923f53"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.21/stella-0.6.21-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c198d62fcad7c8c69a7bae6a3c71cefeb4d0899a01a8b8e70025642bd7bb6ff2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.21/stella-0.6.21-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5875ebf6a21cc2187df067abb74720ee8143ec33d8fb383479812d02edb7e7ac"
    end
  end

  # Each tarball unpacks to a single stella-<version>-<target>/ directory that
  # Homebrew descends into automatically, so the binary is at the CWD root.
  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end
