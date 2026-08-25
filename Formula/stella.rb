# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.220 / @SHA_*@ placeholders below with
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
  version "0.9.220"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.220/stella-0.9.220-aarch64-apple-darwin.tar.gz"
      sha256 "01648112f3a841dfcb5003cff11503e6ce182bbd15d3f024886800f3bd35e155"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.220/stella-0.9.220-x86_64-apple-darwin.tar.gz"
      sha256 "81bc9a03248eccac772ba99556ef84ef072b7825e2d440f3a82832a2ded7a629"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.220/stella-0.9.220-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d66972a713a558e8e52712f9c2d44a2b607b1c89d34cec7f20857f95248a7a40"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.220/stella-0.9.220-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cbb9e2b24c8d4a18d8014ca4601390b84d718b8477e571b554eb09245fe35a8c"
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
