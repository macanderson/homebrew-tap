# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.11 / @SHA_*@ placeholders below with
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
  version "0.9.11"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.11/stella-0.9.11-aarch64-apple-darwin.tar.gz"
      sha256 "bcc5ef35756df3f392f05f66768c3d1dfe37d0f41bdfc433944e7764e2d4638c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.11/stella-0.9.11-x86_64-apple-darwin.tar.gz"
      sha256 "3e76462453c0a6ecfdd51251634c0ede75e333b75c6813917dcb81950ef2d529"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.11/stella-0.9.11-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f307d87f4df43f42af8e445d6b62972d8268fdb54f7f8fd89359dbfe7f332bc6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.11/stella-0.9.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b581ebb3c5e0559d629bfff1cf4ae9bd0b555ad26d264faa9d59663a43f2563c"
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
