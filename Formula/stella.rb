# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.507 / @SHA_*@ placeholders below with
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
  version "0.9.507"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.507/stella-0.9.507-aarch64-apple-darwin.tar.gz"
      sha256 "6e0b061877c4632f56c53ce37d3e9314607d8ed1cd23302542ff300570c55dfd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.507/stella-0.9.507-x86_64-apple-darwin.tar.gz"
      sha256 "881614078504a97c0a60f0ababebd1e46fa313bb3234b213945591895e7246eb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.507/stella-0.9.507-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "35eb4659f540febad58a2611424a0d25a78b474a8ded39e211b9253f0804f647"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.507/stella-0.9.507-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8b6489c0817239f21f7c7bc34f0fcdc91ba5417b23267c90236890a1ff5df678"
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
