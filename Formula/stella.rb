# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.21 / @SHA_*@ placeholders below with
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
  version "0.7.21"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.21/stella-0.7.21-aarch64-apple-darwin.tar.gz"
      sha256 "0aaa5c150e4df6f59513885d0a8cd4bca4ac7050f1d3d930cc701672034b2a9a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.21/stella-0.7.21-x86_64-apple-darwin.tar.gz"
      sha256 "18be3b272358688fd792fc742882663dbd95dd3381982324e33c5c605a41dff3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.21/stella-0.7.21-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e567fb16035c4bf2fd0fef231b3233d223508f04569df3307d6d41d0bb49bfb7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.21/stella-0.7.21-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9ec78692496961205e6582c6b16839763d338d34659e51aad95fdd20d8ba68e1"
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
