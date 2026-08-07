# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.6 / @SHA_*@ placeholders below with
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
  version "0.7.6"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.6/stella-0.7.6-aarch64-apple-darwin.tar.gz"
      sha256 "e1cf693485d147c19739edbf23dc47f799b41acf40e7b249078dd1dde37dfc00"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.6/stella-0.7.6-x86_64-apple-darwin.tar.gz"
      sha256 "338600c62dd6876b22c6e1fa65284a05c001c72ec81f469db716a8b71755dc9a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.6/stella-0.7.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d2320936baae9cf83a16be593a0fb1a65e36a6a6a314247cadf526160f9aa771"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.6/stella-0.7.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5d1f041c785db5ee092a9588d4fdc6f869a808e261426f03c7f576d23cb8159b"
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
