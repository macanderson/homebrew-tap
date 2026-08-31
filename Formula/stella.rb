# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.303 / @SHA_*@ placeholders below with
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
  version "0.9.303"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.303/stella-0.9.303-aarch64-apple-darwin.tar.gz"
      sha256 "c3225f40503c0a86b2aa268cb87b9279ce856f390d60a47055fd75fb75307f62"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.303/stella-0.9.303-x86_64-apple-darwin.tar.gz"
      sha256 "a4aedd660bcf136e787b19d2c0a12802a0f87564e75d34f8d3141fd07e6bf40b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.303/stella-0.9.303-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e58d0db5a15129999221d558d6aa845dceb2a72ee6196f16bb7087c52744a752"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.303/stella-0.9.303-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d9d9b8d7968ecb0dc0d3461c2c4d6ade7486a18eabdbe6f4d018879f65c90890"
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
