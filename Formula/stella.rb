# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.112 / @SHA_*@ placeholders below with
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
  version "0.6.112"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.112/stella-0.6.112-aarch64-apple-darwin.tar.gz"
      sha256 "9cf6bbe1f7f1262b319a75d1d1a74b31e9054f8d1f5abbd6655c4d6ac63212ca"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.112/stella-0.6.112-x86_64-apple-darwin.tar.gz"
      sha256 "b540f4960cb9d739c6d977347907bbc93cd559bdad5168a5400d4432830241b2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.112/stella-0.6.112-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d300604a5d70c0929ec8f50b8d950fd598b4316dbb6784566818d25dc97efbc3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.112/stella-0.6.112-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0c23e0e223132d3ede670dab3bcf5833bdf87ac864886b5e78cc71e4c63d7092"
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
