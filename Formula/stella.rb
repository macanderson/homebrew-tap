# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.195 / @SHA_*@ placeholders below with
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
  version "0.9.195"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.195/stella-0.9.195-aarch64-apple-darwin.tar.gz"
      sha256 "a8d632285fbf1a4544d719f500cf56c702b8bfbc1ffa9e7fa6430ef44d0106c4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.195/stella-0.9.195-x86_64-apple-darwin.tar.gz"
      sha256 "9ef114a89e7166b587a1e16e0b356cf29bb99424b8fb30a2d35c9f70884e79b0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.195/stella-0.9.195-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "564d49637c251c724e60430b274d22255c8bc27fc392eafedcb7ec2c6c4fbdcb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.195/stella-0.9.195-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ba7da2c9863b267139d7f789745c24fa856cf436f37b389459d0fbfe0f7040a"
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
