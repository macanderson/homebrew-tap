# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.4 / @SHA_*@ placeholders below with
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
  version "0.8.4"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.4/stella-0.8.4-aarch64-apple-darwin.tar.gz"
      sha256 "7dd5134132e30a4b14167f271b104bdfd6000e41e9514769c5fc8c3c389f6b21"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.4/stella-0.8.4-x86_64-apple-darwin.tar.gz"
      sha256 "981ec7ba17759cc2f39e8754bd337161869242f1aa78303098b6c86d8fbdfe74"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.4/stella-0.8.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f2ae84348f991dbeb3121e93d9bb10bc49745494f81fca62f1e6a70e8e9d6562"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.4/stella-0.8.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "77df66e1bfcb5b3e8f0669c7fddde0c4ccd2d6fc731cd0665c9c09f6f020d1b1"
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
