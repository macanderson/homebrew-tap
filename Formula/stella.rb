# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.241 / @SHA_*@ placeholders below with
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
  version "0.9.241"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.241/stella-0.9.241-aarch64-apple-darwin.tar.gz"
      sha256 "7e491656f265363fea84e6e53d069417cbe4154083fb6b3cb8915b3538819e75"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.241/stella-0.9.241-x86_64-apple-darwin.tar.gz"
      sha256 "4e391ce264a16b74004d6f9f13e2c6677a58a9e1dace3f29ed98367dc90f15ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.241/stella-0.9.241-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "50cd81d05d0196eb1cb6e16d632426388ccd14a795a036b75c12170edbb9180a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.241/stella-0.9.241-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4a7d899cdb4497a43c4f9a4541b2644e1b02b71726f5778ba702e683b5977c01"
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
