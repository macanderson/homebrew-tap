# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.15 / @SHA_*@ placeholders below with
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
  version "0.6.15"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.15/stella-0.6.15-aarch64-apple-darwin.tar.gz"
      sha256 "8442c6d03e165c83254ae7842a69342034f76d781e664d31126eb7925093f9c6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.15/stella-0.6.15-x86_64-apple-darwin.tar.gz"
      sha256 "0aca86859a0032f572311f1be768e30e1288c7663c5185d00a59a64ef3d10198"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.15/stella-0.6.15-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fea04fcc0bf61c76cf6d944cb01421b176b7bd7ba7130cb1fcd25b68dbea55a0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.15/stella-0.6.15-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0c374b85bcb36b7ed444810072b186d47e0160aa00a09b404f8382f4c1dc1321"
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
