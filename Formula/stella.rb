# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.165 / @SHA_*@ placeholders below with
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
  version "0.9.165"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.165/stella-0.9.165-aarch64-apple-darwin.tar.gz"
      sha256 "a5b8dda919c914d29a0351da9f29b7354ec7005ad10d093c9c1c816a3abe6b3d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.165/stella-0.9.165-x86_64-apple-darwin.tar.gz"
      sha256 "e4263eb1d44e469cc0c511edf5ec2a005da2c8b312e2e82d351aa74e154ff15b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.165/stella-0.9.165-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "943528a04f9946c5dcfdc14d7dbdbb19f5ff45dfb9a6dc473a3383374289da62"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.165/stella-0.9.165-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3e7951478af609b754d87e0cc5c08ce4b918247ddb1395fbfc09c63b5bf43e64"
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
