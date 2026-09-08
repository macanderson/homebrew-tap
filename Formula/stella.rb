# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.404 / @SHA_*@ placeholders below with
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
  version "0.9.404"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.404/stella-0.9.404-aarch64-apple-darwin.tar.gz"
      sha256 "3281e8d60f6521c4d8c71f2835a9fc6834f2717d6eda5f7cf67af665dfbdc315"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.404/stella-0.9.404-x86_64-apple-darwin.tar.gz"
      sha256 "87a8b070821d67205aabd53fc130b7939e53f4ed8fb082ee6c9d1f3bd0e0aa57"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.404/stella-0.9.404-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "40fcea53a3e904d2e0aac12fd549b40acb13846237c2d8d25d2c816af19e26eb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.404/stella-0.9.404-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8d4abb3c0403c2090352e1d0016716d0f896b118d8a02aa47fc1ffd647465acf"
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
