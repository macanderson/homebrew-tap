# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.60 / @SHA_*@ placeholders below with
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
  version "0.6.60"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.60/stella-0.6.60-aarch64-apple-darwin.tar.gz"
      sha256 "0bb5489f0f4502ee7ffa9120ecf7615b26646d09280f91a5f7d0465ea85b1a53"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.60/stella-0.6.60-x86_64-apple-darwin.tar.gz"
      sha256 "7caf9b0d9ce4e9bb48273dfd3d4b3bd416fa799bb160c23672317e96f08471c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.60/stella-0.6.60-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "14b2a8e4a3912f729b732e4078b06788195247330b6cf9661b59b32c21da088f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.60/stella-0.6.60-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "878892d22cf190f819451cbcf3a440c82b8788dd7ba29efef652baefb9bd8576"
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
