# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.1 / @SHA_*@ placeholders below with
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
  version "0.7.1"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.1/stella-0.7.1-aarch64-apple-darwin.tar.gz"
      sha256 "b04ac3f758f85cf1bbdfa8621b075bedce1cd94c97a6a4a501728b04f2cdb4b7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.1/stella-0.7.1-x86_64-apple-darwin.tar.gz"
      sha256 "98c46ebecbfc7635a1752cf3e340bfbb595bcab3dd4b5c58cf6791764db7d60e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.1/stella-0.7.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6cb565fa85c1d5710ca8563adc91409900af4e4f138cf950b7f4dd183bfe26b5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.1/stella-0.7.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "647d85065a83a02cd8f534ac46b79462daaf05df43e6c0a57d316cbe4901f36a"
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
