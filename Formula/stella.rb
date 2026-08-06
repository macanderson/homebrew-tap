# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.121 / @SHA_*@ placeholders below with
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
  version "0.6.121"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.121/stella-0.6.121-aarch64-apple-darwin.tar.gz"
      sha256 "2b8312174a165260a0a8c88fc65be8df21c108d33cd3cfabcd3d3efe6e73e1cd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.121/stella-0.6.121-x86_64-apple-darwin.tar.gz"
      sha256 "98a742ad24f130be01ff808d3f37b6c68b5cf34fbe6cd58f532e59e19382284d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.121/stella-0.6.121-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4aee784f25747ee60a4a4fd940a5ffef5552bb47867a67d74bba617a058ca37a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.121/stella-0.6.121-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "431488852454eb80c725161726040f4421141e0835fea4bf2666ec711dbb5a49"
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
