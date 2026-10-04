# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.481 / @SHA_*@ placeholders below with
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
  version "0.9.481"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.481/stella-0.9.481-aarch64-apple-darwin.tar.gz"
      sha256 "d3d1956b5024a06a8441f27cc91d85bd7763dc7f87dea016c55b626a4506851e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.481/stella-0.9.481-x86_64-apple-darwin.tar.gz"
      sha256 "6a5b45bc15f63a057357f686f2392d71bb57309fa11fd75b1fbec6a70133bed7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.481/stella-0.9.481-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6d49af4e154e52c55745b7df3a8f0b57de1d4604337302c9ded9cffc74dc4713"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.481/stella-0.9.481-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8cf32faf43ceb0dc28709acc362c28767e7c790c29eca010f81f4ee043ffad4f"
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
