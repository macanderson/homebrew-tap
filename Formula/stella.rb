# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.41 / @SHA_*@ placeholders below with
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
  version "0.8.41"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.41/stella-0.8.41-aarch64-apple-darwin.tar.gz"
      sha256 "cf0693b47959eed3f7588ef598af7da3bdd6af6ace6f310d9251def1b5faadd7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.41/stella-0.8.41-x86_64-apple-darwin.tar.gz"
      sha256 "8dee4756653324f50b94e818cad7b82655ad08e9332d5e8d9594fd1ef37c2b16"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.41/stella-0.8.41-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b671524f9132a67e76ca2cf5ac6412518f02a69ee30d7b0d650053da5b9ae708"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.41/stella-0.8.41-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6a4a4ded2a248f0546934ff6ae4345fe143961deed1d9536445010fd85145878"
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
