# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.136 / @SHA_*@ placeholders below with
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
  version "0.9.136"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.136/stella-0.9.136-aarch64-apple-darwin.tar.gz"
      sha256 "8645ca24f23594cff77a8002bd3b9de78b665d1a1f5871d964377bd83fe908e6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.136/stella-0.9.136-x86_64-apple-darwin.tar.gz"
      sha256 "744dd463935232f49d8511e285004272293f2c21e913bbe29046e4f72735a2b3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.136/stella-0.9.136-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7a5fc5e9db989aef6b0b71fd25f60e37fb8f85575745bae0582400f7c55d9858"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.136/stella-0.9.136-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "39729bdbe6be8aa0f0049a006e9143b11eeda058ef3127f0fd1fbcb97aa58fea"
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
