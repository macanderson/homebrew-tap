# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.64 / @SHA_*@ placeholders below with
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
  version "0.9.64"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.64/stella-0.9.64-aarch64-apple-darwin.tar.gz"
      sha256 "4452c6fd1f4f91c4ee36adfd514569ed6783992d8c48df8abe6536862dfa3582"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.64/stella-0.9.64-x86_64-apple-darwin.tar.gz"
      sha256 "137d05358f0aa7d77a294ac131417624b53d073a0bcb87290d7f0815b7d37606"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.64/stella-0.9.64-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "03949468da65b3e6a362c81669890c221a6c811677d651eeaa5649a9509437a1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.64/stella-0.9.64-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c81ed5b97b7c9014d15e0ca3f8bf6f3d03c41b6070e747dcdce60d1c5a26f645"
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
