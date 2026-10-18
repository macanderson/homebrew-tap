# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.495 / @SHA_*@ placeholders below with
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
  version "0.9.495"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.495/stella-0.9.495-aarch64-apple-darwin.tar.gz"
      sha256 "c0a7c6b50b175aae0dd1dc91321ec56765333badacce6fc4dcfd666050721955"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.495/stella-0.9.495-x86_64-apple-darwin.tar.gz"
      sha256 "abc0acb5379c84df10ca07c09906dfb621fe7d813f2e75c6403fedb29e3ba4fc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.495/stella-0.9.495-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "47eee9311ed393ded9483c071a5a2e779dcc7477b8c0b410b64a0d163c66f05e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.495/stella-0.9.495-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "63ffa849bdc6a1179d226d2de9fe3eaf8ecf17f4dd60beb6e021d88e37305318"
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
