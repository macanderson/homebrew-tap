# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.14 / @SHA_*@ placeholders below with
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
  version "0.9.14"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.14/stella-0.9.14-aarch64-apple-darwin.tar.gz"
      sha256 "893cca436cf4d43704261593e4b109002da6c0a151e2e1034edcd158f6a40749"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.14/stella-0.9.14-x86_64-apple-darwin.tar.gz"
      sha256 "214634eb51794303966991424995ce281d3dacc4623beaba6ab6bb4d38ad5c50"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.14/stella-0.9.14-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6a409752177dafbaaf3e39c7c06ba6b9b392fe290b6351449e87c3d89d2b0187"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.14/stella-0.9.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dc1918df0d88e4370b3ac27163408e92e407f16b1cb23de82c338381ba32202f"
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
