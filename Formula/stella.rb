# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.10 / @SHA_*@ placeholders below with
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
  version "0.6.10"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.10/stella-0.6.10-aarch64-apple-darwin.tar.gz"
      sha256 "1d177a242bb93b01012fa1e9d21609ee09b8c404d681f4ac2352f04544b19c93"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.10/stella-0.6.10-x86_64-apple-darwin.tar.gz"
      sha256 "d1a7dd49a39b7f6788cbdbaf50b0394dcdd2e8a1e1c41ad74a12e4a51895a235"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.10/stella-0.6.10-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "657ec82bd3db08d491dbb518321528f610ed0f7679a38a13f89a624756788878"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.10/stella-0.6.10-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5b30a9bc3b15586af6627a45a00f7a13c17e728c6bfffa5c4ea820c8236167cc"
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
