# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.4 / @SHA_*@ placeholders below with
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
  version "0.7.4"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.4/stella-0.7.4-aarch64-apple-darwin.tar.gz"
      sha256 "d66f42272802ffdc329a9ade2879d57596bb3f1a46f5a374c463243621251f3a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.4/stella-0.7.4-x86_64-apple-darwin.tar.gz"
      sha256 "eea9909fe1e56f6a4788de9e3e9e3db9730decc70eb9783c6c480b5f2df8961e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.4/stella-0.7.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7e57fa0581bd39094faf0a54f62bdb6f364aea18835807f3cc8917d20ad8ddcc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.4/stella-0.7.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "85c184251d5d81bbcbf17df2a29a97d8ed46a24310a981ae0ab38bafc99b786a"
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
