# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.9 / @SHA_*@ placeholders below with
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
  version "0.8.9"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.9/stella-0.8.9-aarch64-apple-darwin.tar.gz"
      sha256 "37f95daed056ea95a1fc72d9f5dd6f6d28b1bade5ed49e5abef85da9d212db75"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.9/stella-0.8.9-x86_64-apple-darwin.tar.gz"
      sha256 "515df1cf6411f778c73d194013c5b2b6ba5e79e86c6792c66e5b4d588e529d73"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.9/stella-0.8.9-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1a338d71d4f1f4d1bfc0469cf6e20ff330796ba54dcf6da9d9900d3a7f0f22af"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.9/stella-0.8.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cc7fc6f1cd9ac0e52fe842b45faa3e7c27cc8f0b4218d7f1d0a6bdc9998489af"
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
