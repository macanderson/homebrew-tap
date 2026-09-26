# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.439 / @SHA_*@ placeholders below with
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
  version "0.9.439"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.439/stella-0.9.439-aarch64-apple-darwin.tar.gz"
      sha256 "29b8783f1de6f367366a5e4110c49965d64259ca085e3c1053a9ff0579c63c85"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.439/stella-0.9.439-x86_64-apple-darwin.tar.gz"
      sha256 "7c71c4e3f862c90e92897b3e6d2abfa05c1b903c9e4b0a23ef485863329be09e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.439/stella-0.9.439-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "56895aefa8bd54bc6bfe861e1540cfa15f2b01e198144444574dc13b23fb3efb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.439/stella-0.9.439-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b7fc7664817e47739f874c2fc9f0bf7b09d75b9e361ab30af9d651d2550a2792"
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
