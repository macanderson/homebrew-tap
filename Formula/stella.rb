# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.0 / @SHA_*@ placeholders below with
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
  version "0.8.0"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.0/stella-0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "5aa019697ed78e8937422a4ab361abc077e4560c2db07a286a870b5e9bc9b195"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.0/stella-0.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "72ee42279c7d5518a01c9e90897d09214816005fbfba42adccde5fb555815183"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.0/stella-0.8.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "33009b7e067808db328290ddc91c21c8b35a8aa0fa79aa081ad78c534829aaba"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.0/stella-0.8.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0b6da0b89a9d5e2462c2922296a18fd17fe3caa514c8a8527c7567a87524d2d1"
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
