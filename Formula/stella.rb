# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.35 / @SHA_*@ placeholders below with
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
  version "0.8.35"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.35/stella-0.8.35-aarch64-apple-darwin.tar.gz"
      sha256 "43b626f40f8c7b13ee0b6865c87e95cf07434b270a2ab03fb9e375b026103c25"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.35/stella-0.8.35-x86_64-apple-darwin.tar.gz"
      sha256 "7778fd4fcd22645f2b1f281fbeb986fc28db0877116e47908d7af2300c368b2d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.35/stella-0.8.35-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8982ec87bb15dfa14baf6a40e033312d7f88ecebfca638a09f9aa44cd705bb61"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.35/stella-0.8.35-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "117448e4436a3d5aa141c165faa892f068459bcb6956625fd4ab620b4133381d"
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
