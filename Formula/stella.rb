# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.249 / @SHA_*@ placeholders below with
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
  version "0.9.249"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.249/stella-0.9.249-aarch64-apple-darwin.tar.gz"
      sha256 "9dcab8d4735d70b4f48e815589a7a31c6ad3b12c9545666f3ab877a1179fe454"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.249/stella-0.9.249-x86_64-apple-darwin.tar.gz"
      sha256 "098159a84c6f06c3a5423e8e2b936ebf81c4371c58d12a0408a04cb690064278"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.249/stella-0.9.249-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7c0693f7d721c7311a87cb3e92876f9132f8382d33edad01378d92767b295d15"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.249/stella-0.9.249-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "90f58bd66fd4cbd01e1508a74f9e17aa0fb80e11916e7451b4ad1159893c4fd6"
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
