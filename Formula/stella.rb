# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.90 / @SHA_*@ placeholders below with
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
  version "0.9.90"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.90/stella-0.9.90-aarch64-apple-darwin.tar.gz"
      sha256 "62d60f8470240e4c48023d16c1b75a38d3ded4cb4f51b89e36a8cc2c575f09e4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.90/stella-0.9.90-x86_64-apple-darwin.tar.gz"
      sha256 "1e6ebf39a09fbacdf0cad5d444ea1aad5f1a84e5c7f06fb4069599689b960435"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.90/stella-0.9.90-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e8ce8cc71d5c1905487b3421cb2d06e384852555bd9f6da01918c677d58a33bc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.90/stella-0.9.90-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d44bd3389a842d15de03f3e2b38a382a00de38d80468d028893cffd0d905e8e9"
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
