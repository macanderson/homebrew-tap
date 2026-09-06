# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.360 / @SHA_*@ placeholders below with
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
  version "0.9.360"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.360/stella-0.9.360-aarch64-apple-darwin.tar.gz"
      sha256 "fe0a5d09bd1f5a336bc2d033766d3ab4bead62036cd7ee0f21674790abb2ac16"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.360/stella-0.9.360-x86_64-apple-darwin.tar.gz"
      sha256 "75ff717afc5e4afe86392123bee246452ba12ca42e040fc99aba16c34d53b03c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.360/stella-0.9.360-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "844bb8751a2c25020dbdf99ba9cfff7da8f016d889e2b229e156346be52ef7bc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.360/stella-0.9.360-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b6ad02ffd6a02e899011024f3d81fb083b307f80f78e1a6b3918a4c9bc3d1649"
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
