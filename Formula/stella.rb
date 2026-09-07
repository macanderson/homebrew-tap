# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.392 / @SHA_*@ placeholders below with
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
  version "0.9.392"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.392/stella-0.9.392-aarch64-apple-darwin.tar.gz"
      sha256 "427824a0c95d13f35c1abd8c410a12fe9a764e8a0f55d5346e593e78273d2769"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.392/stella-0.9.392-x86_64-apple-darwin.tar.gz"
      sha256 "55b9942dab9195f9086e95e61aa146aa8cec158ca28e22caaab0f631e18441c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.392/stella-0.9.392-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ddf26c24361981ddb21da2a1a992cbbe40f293e75049215f184e14e35d6f93e3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.392/stella-0.9.392-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "62b27d90f880b3beb27d6f0255f08cb92ca00c69b9f3d4331b334bcae22a63f3"
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
