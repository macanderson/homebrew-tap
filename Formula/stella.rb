# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.122 / @SHA_*@ placeholders below with
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
  version "0.6.122"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.122/stella-0.6.122-aarch64-apple-darwin.tar.gz"
      sha256 "a0ccbedbd0568f7897f5fe2e0523cf2f244f28afdaaee8228de73b1066c02a28"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.122/stella-0.6.122-x86_64-apple-darwin.tar.gz"
      sha256 "ccfa2d6d0c3f58a414fa9a3b3fa3563f54a6bf6e197c2feb7fb95548ae1357a7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.122/stella-0.6.122-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fd54109a69da6ee4e5acbf940b4c626cbb5ab94d4afd749ee14f3ede808276d3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.122/stella-0.6.122-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c18e7f0b715b06e06395a5f0e3c154228a45f1025ca1ed1fbaefa8a431ea42bf"
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
