# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.154 / @SHA_*@ placeholders below with
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
  version "0.9.154"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.154/stella-0.9.154-aarch64-apple-darwin.tar.gz"
      sha256 "fd35e9cdb2ef0cfbbbcc4fc46ec78b693c0f3b1053980d6567b5f9160cf3a025"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.154/stella-0.9.154-x86_64-apple-darwin.tar.gz"
      sha256 "93a3631af3a539e174c6991f4f0c41094494eb73c77a7f80d1ace4354a8d9cc7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.154/stella-0.9.154-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4c3c3bd9793821a622da07c25720d3a28c3e044caca5b72916e9111bd4e6db7e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.154/stella-0.9.154-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d91286f1a4ae015483e69d836530e652c41f1a32618f795714172ec6a80bd886"
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
