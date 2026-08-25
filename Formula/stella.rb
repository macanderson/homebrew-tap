# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.205 / @SHA_*@ placeholders below with
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
  version "0.9.205"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.205/stella-0.9.205-aarch64-apple-darwin.tar.gz"
      sha256 "0e3ecdbb6dbd73a0fa792133c02853b2409910c75db6fb39a68ef34ee1686178"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.205/stella-0.9.205-x86_64-apple-darwin.tar.gz"
      sha256 "75fa1368b8429333df44d30f825b2ae7638938a2d839e6539f420ecb7b92b46d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.205/stella-0.9.205-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fa20c20a85aaca0fc35546adb51ee09425005ceb931f0d2bc65e3e8c3a28ae85"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.205/stella-0.9.205-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f8cd8dea4e4be013c259eb2e1c10e8447ae76efa285bc196963302f16f51fd73"
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
