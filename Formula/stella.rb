# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.71 / @SHA_*@ placeholders below with
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
  version "0.5.71"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.71/stella-0.5.71-aarch64-apple-darwin.tar.gz"
      sha256 "f0a91cbb884a5f28c33c06d0f317c408c1b5a1a0b716384025b038fa49a0b870"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.71/stella-0.5.71-x86_64-apple-darwin.tar.gz"
      sha256 "2e845690cb39105e4e24b4630fbfd790263a104458e197c72d28673a1767f822"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.71/stella-0.5.71-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9dd7b4aa1eb37906454cc8f6bbea1e3a2e7d8b8eac376b060f41938c547a5a7d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.71/stella-0.5.71-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "785c195a7a0a497810e4a1117dcc81d008f79fb49ed14c0ef49333cc75317fb3"
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
