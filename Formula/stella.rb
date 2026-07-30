# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.22 / @SHA_*@ placeholders below with
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
  version "0.6.22"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.22/stella-0.6.22-aarch64-apple-darwin.tar.gz"
      sha256 "fd9eb36bd5db221c5f2cc12f0ca139d35c3c61a4768f5d8ce658c849d37e07bd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.22/stella-0.6.22-x86_64-apple-darwin.tar.gz"
      sha256 "7e3a04d7ab58737e660de471ee08f62b855b03bf82fce76813f273fb476c0762"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.22/stella-0.6.22-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8b7e1909d7623cb1c6c262faa2aa7d3759cce5ae37a06242a961505e4d5f5359"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.22/stella-0.6.22-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3edf92d4cdae236449964433c23c55c55354438c48a3f5a35a02c82aef063505"
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
