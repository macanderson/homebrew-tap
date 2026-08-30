# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.287 / @SHA_*@ placeholders below with
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
  version "0.9.287"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.287/stella-0.9.287-aarch64-apple-darwin.tar.gz"
      sha256 "b98fe11d4b311395af72b9eff5845e395300a90e9209d401ccfe1f00d3bea799"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.287/stella-0.9.287-x86_64-apple-darwin.tar.gz"
      sha256 "d762e48b082b30c2d455d68e5ed2acd8d84d0362a775ec683de93a65a2ca317c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.287/stella-0.9.287-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7dba6958d764f6e772f9183fa699c1d34efaa8b31f77fd792bd8923b61f21595"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.287/stella-0.9.287-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "449bad1075f9a87ab2cbf14ecb379b1da2bf7847152a221dd4b51516867c1f58"
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
