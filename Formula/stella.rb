# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.311 / @SHA_*@ placeholders below with
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
  version "0.9.311"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.311/stella-0.9.311-aarch64-apple-darwin.tar.gz"
      sha256 "6df893b2150e1bd083fcf443bde93ca2bfd2dc9d15b1beb562d1cc247dded516"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.311/stella-0.9.311-x86_64-apple-darwin.tar.gz"
      sha256 "9b2db98e33914134e7e2f6cf30b92060e512f413c5eb0f0cb6c4a738080faea5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.311/stella-0.9.311-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e839e2ddf8c414caaa2aa87d76c9bc3e1cec141b76f261fe1922e384743b8fa3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.311/stella-0.9.311-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dafd89496337790b73f05f4d5741fed2c30bee76eddc5935a550e317108f07b9"
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
