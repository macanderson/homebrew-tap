# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.252 / @SHA_*@ placeholders below with
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
  version "0.9.252"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.252/stella-0.9.252-aarch64-apple-darwin.tar.gz"
      sha256 "2427b01fc3b088f9e722858230ed0fd9b331629af637c938b44af9bf98e2b885"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.252/stella-0.9.252-x86_64-apple-darwin.tar.gz"
      sha256 "f15466a7764bb4ccdd704bd4ec8674995f8719fe50ace113f2fac2bac8418190"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.252/stella-0.9.252-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4c202ba1df8c8b918ed66960b3917b72a1c5dc1fefccbfa3b30df94713323dd9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.252/stella-0.9.252-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6b4ff94a70d2eda13f604d697abba5632d91a6248fb702d913f58253de9abc55"
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
