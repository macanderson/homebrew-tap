# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.159 / @SHA_*@ placeholders below with
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
  version "0.9.159"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.159/stella-0.9.159-aarch64-apple-darwin.tar.gz"
      sha256 "8d80fe52d98c3cb9fe2a7cc9aa712e702c7080fea559a12ffc467a3de62eb028"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.159/stella-0.9.159-x86_64-apple-darwin.tar.gz"
      sha256 "711a4b24f5e38b543be8d74b47f28945ecc15df37aad5cb88d7b2abe0209c3e2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.159/stella-0.9.159-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8439bca2b7e21f4c5e67438274def40d0778b6dac36932b586b8ef361f2b6247"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.159/stella-0.9.159-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c2ebdc4da07f411707ca2bae3e0b521a00372e9cc76a72de21dfe08aa4ecb109"
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
