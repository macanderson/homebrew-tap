# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.389 / @SHA_*@ placeholders below with
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
  version "0.9.389"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.389/stella-0.9.389-aarch64-apple-darwin.tar.gz"
      sha256 "d34ef2e4ba7308f58b626a9afd3031168d7a2516143edbed69029af7e3c6b936"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.389/stella-0.9.389-x86_64-apple-darwin.tar.gz"
      sha256 "d81cc17bc940a59a6ef37357a8e5c8e311983ae8353020fa264d0fa524124f0e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.389/stella-0.9.389-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bd221ca69c4955af5411ac7835158af7f0233ee678a4151f907fe25f43f77d67"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.389/stella-0.9.389-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b172ee8a2696f1d85c9ba836d5a034fd35462fef2ea1d1b5168195f97b44a3c8"
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
