# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.350 / @SHA_*@ placeholders below with
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
  version "0.9.350"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.350/stella-0.9.350-aarch64-apple-darwin.tar.gz"
      sha256 "4fb47d189859606583e3d8068ff456c554f1ea03d507b4cfa40c789f1acbb917"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.350/stella-0.9.350-x86_64-apple-darwin.tar.gz"
      sha256 "bff01610f0b63d428b31f3b70d6fab0731a32f2d5fb07af9638ca4a8e6266e9b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.350/stella-0.9.350-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3f6cdbab97d9954733f5dbe4f87514460b667f203f7fd0c1858f013cf0f0cf4a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.350/stella-0.9.350-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "698f7f3c29c09ed3348cf75c458590990f27a765d4fe0f8cd48b986119206d44"
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
