# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.38 / @SHA_*@ placeholders below with
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
  version "0.6.38"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.38/stella-0.6.38-aarch64-apple-darwin.tar.gz"
      sha256 "1a1a67252cc6b4373b4164d74af8867eec8d4df76c53a02bb434f04a6c80b27b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.38/stella-0.6.38-x86_64-apple-darwin.tar.gz"
      sha256 "be8ee14f30bc68d84d8825ba7abeb07b922ea4da85f3873590b799fa0abfb73f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.38/stella-0.6.38-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "95141571f36fddb71d44208384a8799036c095ddbfb99af62561ebbfdfa9ac31"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.38/stella-0.6.38-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6772169da7b6e7880d7d0e30a3995f96bfc71f7e545c31c9e33a0ee13d46ae2a"
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
