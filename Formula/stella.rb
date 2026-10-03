# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.478 / @SHA_*@ placeholders below with
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
  version "0.9.478"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.478/stella-0.9.478-aarch64-apple-darwin.tar.gz"
      sha256 "2129be31bfd2b0551f30db801b4b79c420addf70babf1b6be6cf9b70dab29698"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.478/stella-0.9.478-x86_64-apple-darwin.tar.gz"
      sha256 "23529963acafd5aeca328efcb6fa02f1c3eb03d2bb1468b7224b0988055d9bd7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.478/stella-0.9.478-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ffa45bc7abf7764dba23e6529a0f6226a82c760c8d83be0e1f41b8a39949c529"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.478/stella-0.9.478-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6989c22a8711c7ff74be95afcedbe39675b484b7800d926fa165169b724dff52"
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
