# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.204 / @SHA_*@ placeholders below with
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
  version "0.9.204"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.204/stella-0.9.204-aarch64-apple-darwin.tar.gz"
      sha256 "11198124270c0ec2b7ff56942c84e6f92fd01c669db203ef1e360feef8e22404"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.204/stella-0.9.204-x86_64-apple-darwin.tar.gz"
      sha256 "3de5983508b2582ee4445982e5d78e167232c472990e3e86ce55fa73f32438cd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.204/stella-0.9.204-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "718b02f254b880e04d98dca91de6b89a9946a611c2c830a74e535e841247b415"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.204/stella-0.9.204-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "87470ecd446636b9f2ef9c66424dd9878b206c9299d565cce2492e416fe33406"
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
