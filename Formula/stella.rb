# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.34 / @SHA_*@ placeholders below with
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
  version "0.6.34"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.34/stella-0.6.34-aarch64-apple-darwin.tar.gz"
      sha256 "f7196ca35d75a6e6586dbf141083a039297590a0406dae17667ef193d40b67d1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.34/stella-0.6.34-x86_64-apple-darwin.tar.gz"
      sha256 "b17d9775c2842928f9f2473ffeffd9cc8b4f5316291f67558365de08dbbc1c86"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.34/stella-0.6.34-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0e1d7bd9c984b7f847a7b32b8b7186ee36dbb3b37230d2a39aebc9bc31570e04"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.34/stella-0.6.34-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6e415d0ad46607dc2ac330da4408d485691525c40145fec4fec34d36e9fddeaa"
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
