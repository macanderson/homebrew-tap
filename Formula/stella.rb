# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.447 / @SHA_*@ placeholders below with
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
  version "0.9.447"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.447/stella-0.9.447-aarch64-apple-darwin.tar.gz"
      sha256 "f868acd30a617101228632802dd6f11e3af4958cc96eed3085c3d3d446d92f14"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.447/stella-0.9.447-x86_64-apple-darwin.tar.gz"
      sha256 "39c21fddb422476b81d77558ca460657d0d545d78460990ff4801d062368580f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.447/stella-0.9.447-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ee698dc489948ac8a60190b046e947bd8a56a88678d513ca5ba7e18ac4f79d9b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.447/stella-0.9.447-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "75e537b13b2a91c244ce9b4b8a981ba7de2cac76c7dc2f5c29834adc4982bea6"
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
