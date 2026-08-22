# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.138 / @SHA_*@ placeholders below with
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
  version "0.9.138"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.138/stella-0.9.138-aarch64-apple-darwin.tar.gz"
      sha256 "500c1609d5e8c8cdaa93e21db5998b2e844e1d929c51b20963d256e1cf56d83a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.138/stella-0.9.138-x86_64-apple-darwin.tar.gz"
      sha256 "0d7185d791bdf0990f1c7e96e19f0350cd2ffc3f1bbb2180d38a8f66aa3029a5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.138/stella-0.9.138-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "41c2f6e1611029d290e08212841aebf328842cfa2d6bd0b7f69db4b1fa2c4705"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.138/stella-0.9.138-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a0f5420beb9a5e1acd243a61ee580bf8bce3d5a7ce67f8c5271867377d03fb5d"
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
