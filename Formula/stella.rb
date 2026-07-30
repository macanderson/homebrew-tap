# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.13 / @SHA_*@ placeholders below with
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
  version "0.6.13"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.13/stella-0.6.13-aarch64-apple-darwin.tar.gz"
      sha256 "65bd931cd19658be2468d217bc8cd6f638853fb6af6a6b988b74b2b8f71acde2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.13/stella-0.6.13-x86_64-apple-darwin.tar.gz"
      sha256 "bff6356564128e8df74f74b55ad6669add5cb905789325825152a8c0ac451cfa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.13/stella-0.6.13-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "82ba9526b76f84e4026141949f7be85f67fd9209fa45034a93ebb2e1235d2d83"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.13/stella-0.6.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "354ecfd04a71d3ac63636a506dcb429c77f84bb1eb68b985d746d4d0f0325adc"
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
