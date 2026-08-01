# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.56 / @SHA_*@ placeholders below with
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
  version "0.6.56"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.56/stella-0.6.56-aarch64-apple-darwin.tar.gz"
      sha256 "ac718b085bc962cdbd9977412c6d3083cb03c2f706d013d17956219a827dae05"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.56/stella-0.6.56-x86_64-apple-darwin.tar.gz"
      sha256 "60c0b83efa526820247fa624aa43739ef8c7154bf99f58f2234b703f11f27174"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.56/stella-0.6.56-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3e6cd35f6f9b5622b084d76a4d23a71452b2a8852db21f80db3a7c772195c29f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.56/stella-0.6.56-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0d47d2a14c4e4bfae87bec9ad32947e56b767cc352bd646fd61cdc946a276a99"
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
