# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.12 / @SHA_*@ placeholders below with
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
  version "0.5.12"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.12/stella-0.5.12-aarch64-apple-darwin.tar.gz"
      sha256 "2ec392bfebcaf97a4fbaf2a8efb20da2df7d2cdfefa3c4d480a80e083118d7db"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.12/stella-0.5.12-x86_64-apple-darwin.tar.gz"
      sha256 "0892a636f39d02906fd1f4fe9a1af842266a7033e4fbfe7f0012cb5c91c5b1db"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.12/stella-0.5.12-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2e34607fd1f0846d3848ac1f51dc733d4c675e2a332bd7f080693f8c9597a557"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.12/stella-0.5.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e77523a8fc6f87f9227b7b42b00e96c759730d82cc23c5ed017f38d56765e664"
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
