# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.29 / @SHA_*@ placeholders below with
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
  version "0.9.29"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.29/stella-0.9.29-aarch64-apple-darwin.tar.gz"
      sha256 "b5cf8efc7c482656176fd98d1d788371d436059091dc4f7fbc2b22a7e282c731"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.29/stella-0.9.29-x86_64-apple-darwin.tar.gz"
      sha256 "896fe18abf40f9cb29adbf78973e0c644c8bc817f19b0b01ef7d3d09a2a18c69"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.29/stella-0.9.29-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0cb34920bd9b26fa1df4db8b4722fef7376c937f83161bd126ce425544a3b8b1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.29/stella-0.9.29-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7dd92d961de336039182821de848c0acd85d274e7c2a3cfe6384451bc3c547d9"
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
