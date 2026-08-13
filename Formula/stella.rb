# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.31 / @SHA_*@ placeholders below with
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
  version "0.9.31"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.31/stella-0.9.31-aarch64-apple-darwin.tar.gz"
      sha256 "a1de37ff57013f6d47cfacbd4e503657e70f159a4b66c0f02e1a7e1fc37fcf63"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.31/stella-0.9.31-x86_64-apple-darwin.tar.gz"
      sha256 "7d83ca38c371e429b7dccae057ce59ff1b6709526b71e95f9693b0b3a34cf602"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.31/stella-0.9.31-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ca9810053dcc505f636e2cd376a6730613ac575f845ef7e714a6e0e3d4d959f5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.31/stella-0.9.31-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "066f1f5642115812b18fa612fcf40b1663596568ab82fcd21457b2a76fae7c6a"
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
