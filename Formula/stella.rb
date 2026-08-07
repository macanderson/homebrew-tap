# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.0 / @SHA_*@ placeholders below with
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
  version "0.7.0"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.0/stella-0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "ed986ec41db5e58b869a3478209613c09d2bf274e1894369791fce1f5f78db28"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.0/stella-0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "4830a13d64847817d5012418afb4cf6cd3442d14407f4a78aa3f4de7f245787e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.0/stella-0.7.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "917d3712470e261ec28355936f9cdb21c0cd8618f7c341161ba2dbb88accee73"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.0/stella-0.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c9dbea790ab6fa636d4535bfa88d9bbc5d6bf0979f5ecb5cb8605bef6dc957ba"
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
