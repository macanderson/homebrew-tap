# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.142 / @SHA_*@ placeholders below with
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
  version "0.9.142"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.142/stella-0.9.142-aarch64-apple-darwin.tar.gz"
      sha256 "be646b807a6cf331ac208a09de51c8b6e9a0620c9413415026b38be88ec6ab66"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.142/stella-0.9.142-x86_64-apple-darwin.tar.gz"
      sha256 "f501d4fed84a62dca803f0e9936c4d1c526ba60e74459bf4ab4cf838a7c1de39"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.142/stella-0.9.142-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d20805f3894988d9fccfcb8a29fd24adb69a40826c102e254894a7aa93368861"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.142/stella-0.9.142-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ff1bdb2f630635cc4f1b91ff4446678ffa8a6574c894858a04aa3b2242dc8c8b"
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
