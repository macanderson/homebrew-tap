# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.307 / @SHA_*@ placeholders below with
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
  version "0.9.307"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.307/stella-0.9.307-aarch64-apple-darwin.tar.gz"
      sha256 "e7af2466b2a808ea540d5713aa9ab26279d674df69089501cfeee13f1e1d3a0c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.307/stella-0.9.307-x86_64-apple-darwin.tar.gz"
      sha256 "6fadd23fbb1502f5ed912d2e99f3e01c07c0e0c99f8215b39df4900fa3bc0573"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.307/stella-0.9.307-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6708ad1d7ee48ebc1a9b920900a233e28fed229e700df9ed3886b98110160a46"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.307/stella-0.9.307-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "80f0375e077633c69e5bd78d90868cf24e61e5353be70836a7fd689fb0a57f9f"
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
