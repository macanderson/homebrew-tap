# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.37 / @SHA_*@ placeholders below with
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
  version "0.6.37"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.37/stella-0.6.37-aarch64-apple-darwin.tar.gz"
      sha256 "705d81e1bc1019d732ec8c6ff5b1475bc67ec896190a0aa7652fdeb49684cb95"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.37/stella-0.6.37-x86_64-apple-darwin.tar.gz"
      sha256 "dec73c51d1247165757ffac3129e3648828359f641aed75b89e1d5c50d9ef94b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.37/stella-0.6.37-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4b3cb2ea5c9dd5db256317473de48d985dacc8daaf5484c804121305d65f9cf9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.37/stella-0.6.37-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dfb3ff29a8b3a282d7b83ca3773aa048e018cb27aba8f0502e50ce6c9bc70781"
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
