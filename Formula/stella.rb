# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.501 / @SHA_*@ placeholders below with
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
  version "0.9.501"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.501/stella-0.9.501-aarch64-apple-darwin.tar.gz"
      sha256 "08d8db85ee299d7669134fd010edfd96aac80301428d2b781cd36fc3869e7d87"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.501/stella-0.9.501-x86_64-apple-darwin.tar.gz"
      sha256 "8fa64cef974a007049ebe3be53f40bb8e4e3dcd2ae9817679836b009b0021794"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.501/stella-0.9.501-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "13aed11deb14e699e1c900f0efedb2f806f9c7fa3d85169c643411b3ac0dfe84"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.501/stella-0.9.501-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "87a55c647c8264c7818f99d60643ce52abbff1c6c23770299acdd0305f6e125c"
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
