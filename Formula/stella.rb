# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.474 / @SHA_*@ placeholders below with
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
  version "0.9.474"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.474/stella-0.9.474-aarch64-apple-darwin.tar.gz"
      sha256 "d388dc0311b373b2ee7692452c835ce164e8cb7ccd8bef5f33a2f44855a53fa7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.474/stella-0.9.474-x86_64-apple-darwin.tar.gz"
      sha256 "04c46aaeddcd193a3f2032a4f2c099a618eaa65095041e19c10ab92cc1e46f40"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.474/stella-0.9.474-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4bc91ce660754f6d5e7459d79fbcba363aa1dd909261d72f52b8100e154b3459"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.474/stella-0.9.474-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c9f372fe03eb430f1634a116cd220ac046e4cfb0f42814df1b3d288d6f35112c"
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
