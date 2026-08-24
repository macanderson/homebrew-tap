# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.184 / @SHA_*@ placeholders below with
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
  version "0.9.184"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.184/stella-0.9.184-aarch64-apple-darwin.tar.gz"
      sha256 "6c46aa21e14c768bf135da94e31a06f59c911a10145457745de2a13fa62705d3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.184/stella-0.9.184-x86_64-apple-darwin.tar.gz"
      sha256 "1de1f29f5f43ccc57217efd94cf94bbc6290dfeb11e1bc6a79910bd745891d09"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.184/stella-0.9.184-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a7f97652d22d1bfc3480cbcf5cd96499810250019fc146f593b800de324c807f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.184/stella-0.9.184-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b5753eb79889502c9d83d072205c620a1dcac812ce1f3b27831866562da15bb"
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
