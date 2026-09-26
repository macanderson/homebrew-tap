# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.440 / @SHA_*@ placeholders below with
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
  version "0.9.440"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.440/stella-0.9.440-aarch64-apple-darwin.tar.gz"
      sha256 "d3577a2a6835cb009bbb443edbae483cd8c86ab5bedb62c76399ef16579f4ec5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.440/stella-0.9.440-x86_64-apple-darwin.tar.gz"
      sha256 "0b4f7769d58a507c3644f15c8ff5968b3d0b6ce813d0e247874b38186a007858"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.440/stella-0.9.440-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bd655266cf7b7941420ff4618e3b19dce5c08b484d552d20a08b42baf865060d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.440/stella-0.9.440-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e69980c837381eeb2f84d307176b8b6df853d2095db70805cf6f8977b6ae5a24"
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
