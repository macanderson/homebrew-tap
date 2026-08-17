# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.77 / @SHA_*@ placeholders below with
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
  version "0.9.77"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.77/stella-0.9.77-aarch64-apple-darwin.tar.gz"
      sha256 "1f7e9a36066823da2d8bfbb5611b6fb6e254aeb7bd2070f7a2f9caf35ab00c41"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.77/stella-0.9.77-x86_64-apple-darwin.tar.gz"
      sha256 "4b72ad1dd2af562e73f6ec91abcf0e6ad8a416c65b2d358a02c384c6bbb82959"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.77/stella-0.9.77-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7b5f96d21b90262537e0e0c9490269b9ba28e27303c909272360730622b270a8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.77/stella-0.9.77-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "934d159d8108dbeb6e4d9d0bacb338272e79263cc68d722a948670e1a8aa28f9"
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
