# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.40 / @SHA_*@ placeholders below with
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
  version "0.9.40"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.40/stella-0.9.40-aarch64-apple-darwin.tar.gz"
      sha256 "7813b70f811286ec245d5197123b0fe699f832562c55ea1094a250dad0dc26ae"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.40/stella-0.9.40-x86_64-apple-darwin.tar.gz"
      sha256 "e0eb742b51ab75e33af9cee4b48dcd948f96e62673ec741c5708508023ebc822"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.40/stella-0.9.40-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0446c4c90b8dd76bca81e28e9a7eacda4acd99d4d505a540d3ce337564ce23d5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.40/stella-0.9.40-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d880fead2422faf6775cd72ba651fd8bfc0ab15b11f67155572da7a5d803c5cb"
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
