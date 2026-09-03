# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.322 / @SHA_*@ placeholders below with
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
  version "0.9.322"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.322/stella-0.9.322-aarch64-apple-darwin.tar.gz"
      sha256 "3ae532a15bfcde6d5e5048f6545de9e278d5d5c19a11a4f7fb3578a25f5a6829"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.322/stella-0.9.322-x86_64-apple-darwin.tar.gz"
      sha256 "88bdc1e0247bb617cbdc5dc99d72d4b26dd3aebe640fc857ffef0373cc1161bb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.322/stella-0.9.322-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e847f2adf3e6fa7c46e30bc3d4768e984eebecb2c757de3f4c9efa0185b7c2a1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.322/stella-0.9.322-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "43a2eeee40c3f301afb1e2558ddbdf97ac284919f9520161328a8e712fc149be"
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
