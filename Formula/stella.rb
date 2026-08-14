# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.44 / @SHA_*@ placeholders below with
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
  version "0.9.44"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.44/stella-0.9.44-aarch64-apple-darwin.tar.gz"
      sha256 "4820731b4b5d5f2a13ca8b3c14599b726f9765cc50ce516c28ce4a96fd790756"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.44/stella-0.9.44-x86_64-apple-darwin.tar.gz"
      sha256 "cbc8f89a13e63fb7e7b784e28098e4bcba9e4065732f2f8a39c6d3a37cad6f05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.44/stella-0.9.44-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "54cdf8a7b4097a581ad12599ed331a48d53755bdaba512e39d4e8ad1188032eb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.44/stella-0.9.44-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "16b5f2b1ac28d646ccfefdc2e16b126cfd7ede09fbc609fd7df3b32803f6ec10"
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
