# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.95 / @SHA_*@ placeholders below with
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
  version "0.9.95"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.95/stella-0.9.95-aarch64-apple-darwin.tar.gz"
      sha256 "5e2a33400b13a2b1ebbfc13622a78315d064893024612634129df1848124200e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.95/stella-0.9.95-x86_64-apple-darwin.tar.gz"
      sha256 "4f771322d2058fcaeb6e342af1ea2667d4991c0bf90629206833e2f2adb429d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.95/stella-0.9.95-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "50fe464f3d79a43261739e30b83a592891ffc5843e95c617142cd6aa1b1fe232"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.95/stella-0.9.95-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6ae85b3d48a17c142ddb1a8e4006af28a098ab7ce8177755e45c2abef2d2793e"
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
