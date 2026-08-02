# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.65 / @SHA_*@ placeholders below with
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
  version "0.6.65"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.65/stella-0.6.65-aarch64-apple-darwin.tar.gz"
      sha256 "c2f51c41b36506ec24a599c6d8cd135df9b57436877597e4573da9a1b890c79f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.65/stella-0.6.65-x86_64-apple-darwin.tar.gz"
      sha256 "d1ee7d14ba1be72b9e8bf49c612714b8e9432528fa83d58317cf3a94543d5d25"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.65/stella-0.6.65-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "75496efb009d57a55c0937e8b77d7934e5eda2044ea9e756fb98b399abfe12c8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.65/stella-0.6.65-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2039a858f0dda170b0c6d95bd3655bd609aa7166e77baba970c2b4079d2073b5"
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
