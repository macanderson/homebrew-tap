# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.85 / @SHA_*@ placeholders below with
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
  version "0.9.85"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.85/stella-0.9.85-aarch64-apple-darwin.tar.gz"
      sha256 "e247abcfd5e13ecba5c1d6feac8adfb61720ac64d0eb22292e8bc580d2f35793"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.85/stella-0.9.85-x86_64-apple-darwin.tar.gz"
      sha256 "5cb70eff818c4fe377f5289dba9060084d0878cfc9b3453282a8cd14796a79cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.85/stella-0.9.85-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e0fedbe715f21f14b19b6378134a3bf9ea5ca83d2a2e2eb79f2ba8f6abd4a077"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.85/stella-0.9.85-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "da395fce6f0969d46a5c2d2d809ceb9388c59257b8b086a80e0a48bec25c0f5c"
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
