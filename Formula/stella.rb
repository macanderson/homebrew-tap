# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.38 / @SHA_*@ placeholders below with
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
  version "0.5.38"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.38/stella-0.5.38-aarch64-apple-darwin.tar.gz"
      sha256 "242edf64defdf7c6ec2a84d359ab217789d508cbee4529c5cd58296a12cb5997"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.38/stella-0.5.38-x86_64-apple-darwin.tar.gz"
      sha256 "a0f4c5218a86dc735a6a3a97216bd40a878e7fd7ef50d3c424b33d13a59f7074"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.38/stella-0.5.38-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "db87aeb34c85d31e30a60ad6ad501c7134e7a9558b5f1a79a71b6a27e1b5125f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.38/stella-0.5.38-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "229e561d7b53b22a510a7727cffd88d6d8f836473566395a18760065660d3349"
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
