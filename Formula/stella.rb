# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.300 / @SHA_*@ placeholders below with
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
  version "0.9.300"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.300/stella-0.9.300-aarch64-apple-darwin.tar.gz"
      sha256 "5862e46a555a6f443a1ef5b3cf8be008954505888f444b90a671292ea39f30b6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.300/stella-0.9.300-x86_64-apple-darwin.tar.gz"
      sha256 "dc862f0c44117aaaa3e0506c14951767e5515965021d4f2da997d5a6cc3e04d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.300/stella-0.9.300-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bcfa58464ee845373627d2ae058e0499335bafdbcbd3168e1c0e4e8f05aa678f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.300/stella-0.9.300-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "389397e9f5d1cde46928c1c6f0054fd6ffd0f0f790062bdcf48b652088198343"
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
