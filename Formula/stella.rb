# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.314 / @SHA_*@ placeholders below with
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
  version "0.9.314"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.314/stella-0.9.314-aarch64-apple-darwin.tar.gz"
      sha256 "5f94b6d33a592bd717e1841462610f20dc93370d73c059b099bbfcbb70b0b47b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.314/stella-0.9.314-x86_64-apple-darwin.tar.gz"
      sha256 "cf5421c787aafdf8a5cd7617fb92e07d39d26ccf64769cb78ca9b75651d5dbb8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.314/stella-0.9.314-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "281bb8a6101c1e5823398d1d985ad00aac30e80c6bec20829f0c383b7b829a6a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.314/stella-0.9.314-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "68db98d0b2d2b04eb93ff96e3b0acb1d532a8be1eb33b1ed2ba8315975408153"
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
