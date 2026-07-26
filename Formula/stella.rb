# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.30 / @SHA_*@ placeholders below with
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
  version "0.5.30"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.30/stella-0.5.30-aarch64-apple-darwin.tar.gz"
      sha256 "a934f44a50f6f5b4a7ac14b3f1daf33ebcff8921a00ab919adf6acc5f3d9f418"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.30/stella-0.5.30-x86_64-apple-darwin.tar.gz"
      sha256 "964eb46b26cf6225d7a9368a1a142404d6638c9fff947e76af8f0a3e7169283a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.30/stella-0.5.30-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7536622e222f6b9bc70a5bccd528db6b400c53d79d41e640cf730ecd9b9d0b7c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.30/stella-0.5.30-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cc7c447c0584d79dbd95f478634b3dc2dac473e074cc731161dcb045d08b711d"
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
