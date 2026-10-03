# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.480 / @SHA_*@ placeholders below with
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
  version "0.9.480"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.480/stella-0.9.480-aarch64-apple-darwin.tar.gz"
      sha256 "69be90204ce7978a3b4d0c4cd29fa91f3278debd4229ffdb0e8112cbae973b73"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.480/stella-0.9.480-x86_64-apple-darwin.tar.gz"
      sha256 "97ec18f2ec56dc223b33b7b2cecbd1c04783b45c67c29b55062a6483ae067a5c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.480/stella-0.9.480-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6f42d3e1a062ac53054319187f2c677bbf6367fc2c62e8f5e0a870372a0de577"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.480/stella-0.9.480-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "00d9bb0c66832844e095479386ff21135cc332d7a84b1e40c2df0e6940c30cd1"
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
