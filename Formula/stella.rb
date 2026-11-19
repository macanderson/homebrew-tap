# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.523 / @SHA_*@ placeholders below with
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
  version "0.9.523"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.523/stella-0.9.523-aarch64-apple-darwin.tar.gz"
      sha256 "8eed3e8a5dcdf41a8a7f7fb60ffdcc58154df5e280f694a2d742093d1b1e2b22"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.523/stella-0.9.523-x86_64-apple-darwin.tar.gz"
      sha256 "a2e9c388e698027f175c0f1ebd6166983827f75fdb46bb4949c143303869473d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.523/stella-0.9.523-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "719767e8629ff03d6fec918f8a57c8118bcfbbb4bac52a6bc9af610a9c4b66ce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.523/stella-0.9.523-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "18ec5926c74e4cd970862b9ad65133811e3e838dbd87c464c41a56b16257ac35"
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
