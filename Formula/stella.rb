# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.414 / @SHA_*@ placeholders below with
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
  version "0.9.414"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.414/stella-0.9.414-aarch64-apple-darwin.tar.gz"
      sha256 "094a34dfeea6d962c7c79a6fb965cc7a3c8ff4159d81251dfc546628216b6169"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.414/stella-0.9.414-x86_64-apple-darwin.tar.gz"
      sha256 "e509848a1e4b55bd10f9a55c266d4d15db9bbf563f39aea0b4a1679577d015a6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.414/stella-0.9.414-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "38d111cdc6293a0f7e9ff1b44711f0b08abee8356ceb4c0445a05e50e84487ee"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.414/stella-0.9.414-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0592907d4063a47a37e79225e6cec584a18fb24a57afe5900215a8bdcf11a6b0"
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
