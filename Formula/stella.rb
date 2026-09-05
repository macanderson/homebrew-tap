# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.343 / @SHA_*@ placeholders below with
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
  version "0.9.343"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.343/stella-0.9.343-aarch64-apple-darwin.tar.gz"
      sha256 "2ab71e52a489f664096daac6ab93c2b4152a75d252c2d284119a6864ca344abb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.343/stella-0.9.343-x86_64-apple-darwin.tar.gz"
      sha256 "ffdc9c5176f06f628450c426c828f086976c4e378d4e365d4c81e8615e457416"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.343/stella-0.9.343-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "59f92dc6bc27baec967c5ef884f033d351abbad39a2da4dd2c43789b7dbc8f10"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.343/stella-0.9.343-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e83fb59c5be75d16039ff5a96dd40bae4d0746f3ab50e8d590961cfb5732dfde"
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
