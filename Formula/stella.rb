# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.402 / @SHA_*@ placeholders below with
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
  version "0.9.402"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.402/stella-0.9.402-aarch64-apple-darwin.tar.gz"
      sha256 "d872938e397fdc8afdb0e0b61effc290c914d4f16b2c7cc7e7401c0b41f33347"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.402/stella-0.9.402-x86_64-apple-darwin.tar.gz"
      sha256 "76d2234347c9c118903d3ce97684ea309515c59ad58d6dd842490bbe1fd74945"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.402/stella-0.9.402-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0870bb8a7846232e1b468a3d329b118386d03c6be260999a855d0e40d98c884b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.402/stella-0.9.402-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6103b09d2adb8d55b73ff889347221ef91141a49894ced878f19f67701e6674d"
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
