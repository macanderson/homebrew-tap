# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.70 / @SHA_*@ placeholders below with
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
  version "0.6.70"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.70/stella-0.6.70-aarch64-apple-darwin.tar.gz"
      sha256 "57fa1674f81c6a03baca62f5003128da2f8ed5ee47dfb0273089669ad27ef8b0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.70/stella-0.6.70-x86_64-apple-darwin.tar.gz"
      sha256 "5c3860eba5fc99252c28ace06c6257c3d6bcc87482a5704694350765c9fff275"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.70/stella-0.6.70-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "60f3181404f255ff6222d03940e8aba95d7536e74966d8f96de5521b6e8357b8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.70/stella-0.6.70-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "50cf575c3cd2e492a76c26edb58707d27dae07effece50219d84cf327ad8da96"
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
