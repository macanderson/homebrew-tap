# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.500 / @SHA_*@ placeholders below with
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
  version "0.9.500"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.500/stella-0.9.500-aarch64-apple-darwin.tar.gz"
      sha256 "5464c1cf7099e9cdcd2f9fe0b6a6a57e1bb602b31ff3c71abca5f593263c9c13"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.500/stella-0.9.500-x86_64-apple-darwin.tar.gz"
      sha256 "f2f37ec1a53ec2d6c9f38d267b6bcbee3fe521b5e4292a2c1a3a6feaa105a35a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.500/stella-0.9.500-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c62eb20e2ae1ef2d895c09d5c92e378f6befb703d72660e585084ca3cb057655"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.500/stella-0.9.500-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "54a8fbdeea356a72c25189ba0c7fe1847b3abebba7246e3fc8341edf21d06fdf"
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
