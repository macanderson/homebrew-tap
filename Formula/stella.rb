# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.268 / @SHA_*@ placeholders below with
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
  version "0.9.268"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.268/stella-0.9.268-aarch64-apple-darwin.tar.gz"
      sha256 "a4a17083eeff3a91f9b08f62124f06df00b4a3e11fcda82caf04c46c7b2858d2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.268/stella-0.9.268-x86_64-apple-darwin.tar.gz"
      sha256 "29b0fc7a72958d9a47bc5ebd53481b4b6e958e86b571c3c6d50c155d17356c70"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.268/stella-0.9.268-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "081f8fba67d884caa14790340a761ac1278188938b81a0df9c761f0c61ab2c2d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.268/stella-0.9.268-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e35aab50e76f592b9446727b4ee03cf27d07e306397e99e77601a1a5bc4eede4"
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
