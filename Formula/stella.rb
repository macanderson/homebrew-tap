# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.384 / @SHA_*@ placeholders below with
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
  version "0.9.384"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.384/stella-0.9.384-aarch64-apple-darwin.tar.gz"
      sha256 "32af31a9f0c941b25c46be80db779f39b9abe4d8ed2dbb05d509db4fc54f2dc3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.384/stella-0.9.384-x86_64-apple-darwin.tar.gz"
      sha256 "538d0b707767d6451d472ed53e21963a2fad33c7fc6f963a68066806eb518865"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.384/stella-0.9.384-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b789d396760f3b08a5782c281fcb6f3260966332d4888180c2aafcdb819d739f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.384/stella-0.9.384-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "20ee4b6d3f61f081589596afdf7043148183fdd2e7df0d643a86d6523089b0bb"
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
