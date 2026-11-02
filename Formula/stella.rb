# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.504 / @SHA_*@ placeholders below with
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
  version "0.9.504"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.504/stella-0.9.504-aarch64-apple-darwin.tar.gz"
      sha256 "c74df349a37af304d60c1fc0d1ef9aed018e9985680f39ae8bc80547de7a6abc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.504/stella-0.9.504-x86_64-apple-darwin.tar.gz"
      sha256 "fccff4686c68f58259ef7bf5e256e5dc8d2661e5e9988a5a07773255d5f25249"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.504/stella-0.9.504-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c52e6e378c439f79d3e253b79aa77eb2429feaa8f4230ccb548bc8813aa14951"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.504/stella-0.9.504-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f9eec6f223d49d81ca9565599564de1b6bff7d23170416bca6172934b10ab7b2"
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
