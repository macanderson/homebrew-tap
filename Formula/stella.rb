# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.52 / @SHA_*@ placeholders below with
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
  version "0.5.52"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.52/stella-0.5.52-aarch64-apple-darwin.tar.gz"
      sha256 "553c26cb7a401e3d13f83ece70484cb3ac74b43fc90f93465fd96829c9b747fd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.52/stella-0.5.52-x86_64-apple-darwin.tar.gz"
      sha256 "86de618077bc9c6ffc271cd46dec69c8ec2ae05b5ca7222711a31d5bf38eaf6b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.52/stella-0.5.52-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9ab021bbd07c0a0d1ff345ba60193a370da7f70e3ec50bad0138f6aba02e7dd2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.52/stella-0.5.52-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "288273abfdce6f720e11b6ae385341aec2bdab2a6262cff20249d8199a2568d6"
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
