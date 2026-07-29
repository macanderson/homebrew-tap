# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.2 / @SHA_*@ placeholders below with
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
  version "0.6.2"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.2/stella-0.6.2-aarch64-apple-darwin.tar.gz"
      sha256 "cd149449699bcd345632167f7d40b2c0e44ced0508957ddff58f9ef4a937755a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.2/stella-0.6.2-x86_64-apple-darwin.tar.gz"
      sha256 "db7ae6e1773439abf345f6ced63e39d6859bc1e884ad2015862efdf02ccbc24b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.2/stella-0.6.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d78eab4feecdea9561022e41c1ea6ce2d6adfd2b8be58b11235e6ba76cbe46ab"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.2/stella-0.6.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5bcfa4801b8c22ca80408a434beb43229d9b1a6c05fda54fefe16c547cc8f997"
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
