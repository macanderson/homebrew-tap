# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.227 / @SHA_*@ placeholders below with
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
  version "0.9.227"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.227/stella-0.9.227-aarch64-apple-darwin.tar.gz"
      sha256 "926ba37b672024696419959f5f05b6fc74eae14de4578067d8715bf078062ca0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.227/stella-0.9.227-x86_64-apple-darwin.tar.gz"
      sha256 "c33155227ebe8e8f12062816cda282bc5249dc606b0ff32449a9ac2c6e8b31f2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.227/stella-0.9.227-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "22c83460cd59e800eebe8b2e8e44f6d1d4f510c88b670ef21e7ccc9c86ff07e2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.227/stella-0.9.227-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a4e8400dad058c0e8e8a841e26cde91a44129e4a72304417a6a9d51013471ae4"
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
