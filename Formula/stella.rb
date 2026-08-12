# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.20 / @SHA_*@ placeholders below with
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
  version "0.9.20"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.20/stella-0.9.20-aarch64-apple-darwin.tar.gz"
      sha256 "e5ec239beab631f5129afabd2b8a7a2afb7c0eb595d6316f97ea4fa8ab1382c9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.20/stella-0.9.20-x86_64-apple-darwin.tar.gz"
      sha256 "bd5d914bf9189bfd090603df19c948a542d846fad8c567d3f69377996b7c7a9d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.20/stella-0.9.20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a411f468ac95ebc4dc71bcfe1cb28981827d02f004256241ae9d9925a0e4e4a7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.20/stella-0.9.20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c7a6b2edb76a9c64017b1a9d30a7e22bb8c292c7e22f9da855c4eabfbd22d17b"
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
