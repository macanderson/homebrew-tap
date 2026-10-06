# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.486 / @SHA_*@ placeholders below with
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
  version "0.9.486"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.486/stella-0.9.486-aarch64-apple-darwin.tar.gz"
      sha256 "8a123857290d7304eb7fb8a90e9821f8d13fd643cbdef84bfa5428643c78bb22"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.486/stella-0.9.486-x86_64-apple-darwin.tar.gz"
      sha256 "bca0ac843ee492f279c8c694a97a86beda509e0353401ed8d9503c71591bde8a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.486/stella-0.9.486-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "07d1a11d2027ad87a18a9d1e7269dbce16a5ee54beb27d44b5f353f920409e14"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.486/stella-0.9.486-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "efdfd7a5933c8662ac77d3985188f4cf09ec0e5101e86d8efe05d74de028c2dc"
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
