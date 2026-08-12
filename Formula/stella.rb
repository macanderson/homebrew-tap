# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.6 / @SHA_*@ placeholders below with
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
  version "0.9.6"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.6/stella-0.9.6-aarch64-apple-darwin.tar.gz"
      sha256 "cf8bccecb44d4e07d5a6fe12566fe73b26dc1af4f7dc058a26c4dd9533e1fdf6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.6/stella-0.9.6-x86_64-apple-darwin.tar.gz"
      sha256 "0295b434ceff73180924588a0d47470012e6d1f86a796a24459d8626356276ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.6/stella-0.9.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ac2bc3e2f5db5973c625c7f3155e9e350cb0fb54340f8626c0372f329b0b5a59"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.6/stella-0.9.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bb08bb7ea33d40d45f481f3e71eac1aaa6a91d280be15edbb9a1f1488e702c31"
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
