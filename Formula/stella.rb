# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.1 / @SHA_*@ placeholders below with
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
  version "0.9.1"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.1/stella-0.9.1-aarch64-apple-darwin.tar.gz"
      sha256 "2ad6e00040d9fe7ba95b7dc53d9e47237f5380c01bfd59c631d0982641e4eb09"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.1/stella-0.9.1-x86_64-apple-darwin.tar.gz"
      sha256 "18d67a0741b9e719223ca7a899a064b0329be82251ab39fc588df399237b6b2d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.1/stella-0.9.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1ba72d6a56aa6ad8468cf1e60ea01632fefd8d6b4b88742c9b595630418b073c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.1/stella-0.9.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "aa10e4497349195c5b7ab6d4be234876390e928a604b49e01b439f1a28b8e780"
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
