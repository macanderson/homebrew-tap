# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.269 / @SHA_*@ placeholders below with
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
  version "0.9.269"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.269/stella-0.9.269-aarch64-apple-darwin.tar.gz"
      sha256 "94fd3256269bcfcf0f2dbbc28e5aafe6b0020d580332e8d260c9b22e6df62f8b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.269/stella-0.9.269-x86_64-apple-darwin.tar.gz"
      sha256 "60bc41eaeb4513a487d5e44a18ec9f61632a268b93fe504181c040f410e99f00"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.269/stella-0.9.269-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a7c12332e0188114007e2c88dae239d3d12062c76f7b0223d85cf5d681f79b11"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.269/stella-0.9.269-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4ba8de1c0acdefbdfa6c85ee428c2b3c3ad10b1334ff5c43bd37b30bcb581560"
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
