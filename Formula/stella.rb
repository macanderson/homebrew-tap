# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.59 / @SHA_*@ placeholders below with
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
  version "0.9.59"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.59/stella-0.9.59-aarch64-apple-darwin.tar.gz"
      sha256 "cd009b12f829e7a989614d1c5fd23e641d5adafb1d13a9b292ea7dd95dddaec5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.59/stella-0.9.59-x86_64-apple-darwin.tar.gz"
      sha256 "6d565c4c3f76fc90a3107dfcaf1c4dfceddadfa7534c39904a457d5f39615091"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.59/stella-0.9.59-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "37416f3f4ce324230d986fa332f112de5f7c4878c676784d6728dfc39f0f5659"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.59/stella-0.9.59-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a18f40923c270e1e4c1ffc1ec31fa4018da3f72c4ee249f00fee88028010c5fb"
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
