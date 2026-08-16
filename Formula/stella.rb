# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.50 / @SHA_*@ placeholders below with
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
  version "0.9.50"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.50/stella-0.9.50-aarch64-apple-darwin.tar.gz"
      sha256 "421f41a5b2073451db7a8e0138eeb3eb3e864de52e779366d0efea0079ec4ac0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.50/stella-0.9.50-x86_64-apple-darwin.tar.gz"
      sha256 "31c2c85dac8d964d67109af96ded7a6a4fc3385f340860ca1f4c083194d0da26"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.50/stella-0.9.50-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "022fde60443ab56ea2b9e7c4ffbd482834453153a8d76504297f07bce71f0973"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.50/stella-0.9.50-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bdefc1c5387458dc9993beb3144632ef29279f8cba2f97e7822dc984c12bb6ef"
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
