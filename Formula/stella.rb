# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.491 / @SHA_*@ placeholders below with
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
  version "0.9.491"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.491/stella-0.9.491-aarch64-apple-darwin.tar.gz"
      sha256 "acd4869d557652bbf9d887852cb28c5d53fb0d04cb9c0c574f2df69dc10d7b1a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.491/stella-0.9.491-x86_64-apple-darwin.tar.gz"
      sha256 "547360535b6a6112223adccd9044977115f87af4d6c419ffdf7cbc2ec56105aa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.491/stella-0.9.491-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a3673e967445096d3eeb914b1713dd1a20edfaba7915d4bad9ce820833092e31"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.491/stella-0.9.491-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e99315ef8831486f5c3dbd234e6b71866c1dd6ce07f7bf2e985045618f3c6aff"
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
