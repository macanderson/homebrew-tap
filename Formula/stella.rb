# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.10 / @SHA_*@ placeholders below with
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
  version "0.7.10"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.10/stella-0.7.10-aarch64-apple-darwin.tar.gz"
      sha256 "04dd71cb11d5b81f70d7399edda834251acb652449259c8d95cfff4e738ea7aa"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.10/stella-0.7.10-x86_64-apple-darwin.tar.gz"
      sha256 "1a6a0be9247e1a19d816437f8e866712f1826e30aa896319464dca0458a6b1c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.10/stella-0.7.10-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c7f5f38bd82b7da58f0a61ced42c0866e03b457b54fd1596c7647206c98b9426"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.10/stella-0.7.10-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7f15c162f0eff37bf3a2123f740eb79e6dca65b0539e1a9a5ee771104959a652"
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
