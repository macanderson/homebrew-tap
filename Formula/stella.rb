# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.296 / @SHA_*@ placeholders below with
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
  version "0.9.296"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.296/stella-0.9.296-aarch64-apple-darwin.tar.gz"
      sha256 "b5a49eecb8a24cfb80f77ab8380c2eac3de73b1ff770c06da77962a2a882e3e4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.296/stella-0.9.296-x86_64-apple-darwin.tar.gz"
      sha256 "dda97d1246c8c19013fbb935e076d95c7bfecad7341ac9ed642662c25b6d0731"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.296/stella-0.9.296-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1db24d9f9d8c66e38ed88d22358c95931658f8c9def28f7f15c6583352d96feb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.296/stella-0.9.296-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a50cf4bc90d9bb7a6a5f3374e9fa0fc255ff2bc113ca45c065ccc4771ec958b1"
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
