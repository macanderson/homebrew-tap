# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.175 / @SHA_*@ placeholders below with
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
  version "0.9.175"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.175/stella-0.9.175-aarch64-apple-darwin.tar.gz"
      sha256 "93bb0c70c0c4843265e17e350e6fa16a76f4afc3a949637834719699d205c304"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.175/stella-0.9.175-x86_64-apple-darwin.tar.gz"
      sha256 "f391346c13500a28217a5e90a7f84c532448c02d83b675fc2a58ae9b6f5bc1e6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.175/stella-0.9.175-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7d0b753f633e6544d1be1eab02799e8158a3e19fb5e67aa697b80fa7b67d44d7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.175/stella-0.9.175-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1aaf5bb7f5b3e08908614cb9d38e97b8a3532e25750a42613dee5a52cebf7b92"
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
