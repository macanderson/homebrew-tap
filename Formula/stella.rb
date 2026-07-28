# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.72 / @SHA_*@ placeholders below with
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
  version "0.5.72"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.72/stella-0.5.72-aarch64-apple-darwin.tar.gz"
      sha256 "c330d084c0cb453832d9f0e2bcea4e8b5c942e06fee4b2e4681faf6868df58d8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.72/stella-0.5.72-x86_64-apple-darwin.tar.gz"
      sha256 "d8c3a38e738b019c4c920884f77347b8b9e567018d5a45bfc497305a123508c7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.72/stella-0.5.72-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e78c0d9d0525b1b60082901c45168965d6343f1ec5fd16b48f993b82d0c5581d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.72/stella-0.5.72-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7bec429f7e36a8f015ce929f2479edf60f80fe1d2cc6f86aa852c31ac20c1805"
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
