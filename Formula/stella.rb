# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.32 / @SHA_*@ placeholders below with
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
  version "0.8.32"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.32/stella-0.8.32-aarch64-apple-darwin.tar.gz"
      sha256 "0d4d31948b25787bc4da6208fbedaf20f4bcec0e4471e4b75d4de317c4b79acb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.32/stella-0.8.32-x86_64-apple-darwin.tar.gz"
      sha256 "4236404f4658f2f9b509fd71266df94c2725a050a7a37dea66bb7f5fe7e74f11"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.32/stella-0.8.32-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c3e3d18df20ea9cd03696f24bb70636302a99911846b6089f560cf1f88d3df5a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.32/stella-0.8.32-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0067eb9b4b7bc1a6d1d5eba6c092413bdea1c69751b163cd22053f669a0608b2"
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
