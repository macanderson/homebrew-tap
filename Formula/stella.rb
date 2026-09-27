# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.442 / @SHA_*@ placeholders below with
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
  version "0.9.442"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.442/stella-0.9.442-aarch64-apple-darwin.tar.gz"
      sha256 "86dcadd03e1a766ec2454da61b14c5599ed32e06c193f1d4d2664382153a5dc9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.442/stella-0.9.442-x86_64-apple-darwin.tar.gz"
      sha256 "c28d1775fe545db4e8d9cdd3609256193dadb72506ca1b85a19b43f6b8a171f4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.442/stella-0.9.442-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c23166aa8851f5f190583dd8335a9501f63175cb5e087a56448de849b652c3d5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.442/stella-0.9.442-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2e4a15b7f8819d8891a479e40b75cefa67f9fac1e2b5c3d9e3651605dd888e36"
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
