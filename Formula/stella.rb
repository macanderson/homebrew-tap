# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.113 / @SHA_*@ placeholders below with
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
  version "0.6.113"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.113/stella-0.6.113-aarch64-apple-darwin.tar.gz"
      sha256 "877a14222050dfa09ff2c806c9043082c80acec31df0b79cf5102cb74acf4f1d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.113/stella-0.6.113-x86_64-apple-darwin.tar.gz"
      sha256 "654a982ca3e4252a3a778fb8ee34c4a38d510f65334ce6badf00dcc975909868"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.113/stella-0.6.113-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6e72b7789b1f6e1aab288492c63c947769256a3111179d9fd0bd49e5d26376b0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.113/stella-0.6.113-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9d7e0a9421e2d58aceb609aedf971a337067e6a46bb25be7cb105beb436a03f7"
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
