# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.53 / @SHA_*@ placeholders below with
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
  version "0.5.53"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.53/stella-0.5.53-aarch64-apple-darwin.tar.gz"
      sha256 "38eeeab5905fb64af5ea4199f2d14c0b99e30a33ebfc2512dc1242a881110c01"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.53/stella-0.5.53-x86_64-apple-darwin.tar.gz"
      sha256 "29726906ac491e667824dbb41678e553bba5f81dcbcc64fc1271ef5e195d711c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.53/stella-0.5.53-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "36be6e41bb6512ac79cf0f1a0377d4f0bd2c4df5f63fcbc96b9feaa4db00422a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.53/stella-0.5.53-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ceaf337fb0fa8643bb80594706dd2007f612b55772706fb30c74f43e14bf03e3"
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
