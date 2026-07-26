# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.46 / @SHA_*@ placeholders below with
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
  version "0.5.46"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.46/stella-0.5.46-aarch64-apple-darwin.tar.gz"
      sha256 "fc2f4ae7ab03132285e9721a8101000699eac38da22839569a0d845c6f74a999"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.46/stella-0.5.46-x86_64-apple-darwin.tar.gz"
      sha256 "0e5615d0f4fff3527ba7fca0e1136b15ceca8e2d9c541982353b738c37e5b4e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.46/stella-0.5.46-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7fc8fb17461359e9c25b257e730c160f54c276aef5a1e29a0d7b13310f83cb74"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.46/stella-0.5.46-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8d72038c88a9a6adcedc793f38ab95f02cd4f5236556f002b48112aa934aec82"
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
