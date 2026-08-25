# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.215 / @SHA_*@ placeholders below with
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
  version "0.9.215"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.215/stella-0.9.215-aarch64-apple-darwin.tar.gz"
      sha256 "910a5190451ec4063e39b513704c80ec91687b7373fbcf81938a4bf5779814a0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.215/stella-0.9.215-x86_64-apple-darwin.tar.gz"
      sha256 "975499e43f536496aa6f0a5d5eed433b7509525bc609758b5d112902ce481c49"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.215/stella-0.9.215-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7bd3c60ab65f2c12f302258a14993d2d6ced90a46dc0fa24927c19886e0237ee"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.215/stella-0.9.215-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6042d7b0ce31c0897e8e532848917a75780c36fb37ea38bd45444086fa1a93a4"
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
