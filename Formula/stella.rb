# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.450 / @SHA_*@ placeholders below with
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
  version "0.9.450"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.450/stella-0.9.450-aarch64-apple-darwin.tar.gz"
      sha256 "84abaa0609ef2156f4304658fe2cda2d01ff2a44d66876a9370857fefeb43cc1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.450/stella-0.9.450-x86_64-apple-darwin.tar.gz"
      sha256 "14a5f43c4d1e8c88f5d1efa6273463e6a0a500af538f1e9cd7ba7a3b3ce09f81"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.450/stella-0.9.450-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ff5399952ad763e14cfd0b264ec23daceda496c891aa4ee2b1d4f794c4e8df2b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.450/stella-0.9.450-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "198b418ab08fb0b0a10facb3b430e96864f8d256d6bbd62a2a8af66deac2b6c2"
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
