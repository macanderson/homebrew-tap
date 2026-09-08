# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.406 / @SHA_*@ placeholders below with
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
  version "0.9.406"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.406/stella-0.9.406-aarch64-apple-darwin.tar.gz"
      sha256 "146bb10feed53fc986aa8dc8c8ee84d139309e608677b80a3eb6d57e3f111097"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.406/stella-0.9.406-x86_64-apple-darwin.tar.gz"
      sha256 "766fb17c96a0b62e7cc04333cd52156125812286c2aae47a7de13a06d1cf4392"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.406/stella-0.9.406-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "78bd8c5aea0f73bb44a4986629e008439718c77d74afb347e007416a98dd378d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.406/stella-0.9.406-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3b92a83a3d01132ed1d08a7b7beff73ceedbe21a20240a67c9071c73f7ac2456"
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
