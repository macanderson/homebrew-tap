# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.26 / @SHA_*@ placeholders below with
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
  version "0.9.26"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.26/stella-0.9.26-aarch64-apple-darwin.tar.gz"
      sha256 "7f2b904e72a0f1cd452d2d4d02f763a3695f475fe71c2a1946b32a898e87fb97"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.26/stella-0.9.26-x86_64-apple-darwin.tar.gz"
      sha256 "5452cc8078625f855542f099b2fb89d5ebbb6c5e41c7b6f203b31269a4a6ae14"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.26/stella-0.9.26-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4de8a8f85169a016c983daa9ea98608da4a107a96afd46309c7ff332b2ff1a02"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.26/stella-0.9.26-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4c343b1836d4b6d594b721afdb606cacdbdcfe1b0f3f2753a90dede2abfea022"
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
