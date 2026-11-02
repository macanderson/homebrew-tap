# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.505 / @SHA_*@ placeholders below with
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
  version "0.9.505"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.505/stella-0.9.505-aarch64-apple-darwin.tar.gz"
      sha256 "6392c05edd6a3e0671ffcfa831ec5cf20bc45e7e63a32bef075d52480c1c712b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.505/stella-0.9.505-x86_64-apple-darwin.tar.gz"
      sha256 "9c68c17e5be25446b6292e81266a8575682bc33094256a7466560ace93fc8556"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.505/stella-0.9.505-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "82c69f4045adec97bb27e8feaf26cdfc098b445c9bf4643648d5ac15f4b0de59"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.505/stella-0.9.505-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "03f881dd72415a6cff32b5257845e492bace84c9bebfb0d40b68c9652c64c851"
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
