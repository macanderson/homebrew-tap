# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.475 / @SHA_*@ placeholders below with
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
  version "0.9.475"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.475/stella-0.9.475-aarch64-apple-darwin.tar.gz"
      sha256 "2fb8e8ed0a2163442b5afb0356e20231af59d54e211a89dd5dd11c10470d9ff3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.475/stella-0.9.475-x86_64-apple-darwin.tar.gz"
      sha256 "6021cc6be8db9168eb614bd3487a817fe7ad1f6d279b8b864c2132b7e6d49bc5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.475/stella-0.9.475-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6adb580d8a42a79a36693dc4ce1359da472aa0671d0050b77542766c4a4f4d4d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.475/stella-0.9.475-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0cbe5cb6bca7aea0371e655a15a11bce6999703c7ed337b84622962ca2d49037"
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
