# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.18 / @SHA_*@ placeholders below with
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
  version "0.7.18"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.18/stella-0.7.18-aarch64-apple-darwin.tar.gz"
      sha256 "cfc536b41f046721504b4b97c6c8bc89bfd9f8417fb9d632a270f60b07c5d15f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.18/stella-0.7.18-x86_64-apple-darwin.tar.gz"
      sha256 "36e60e0439d684d9a63a4afa4daa7e9322306b3b098d47bcf9d8bcdb35419250"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.18/stella-0.7.18-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2c1278de39ad638da66abe976de513d015445c6dde43086fad1c3404bd6c0cff"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.18/stella-0.7.18-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f2be0c1c23ebdbf8120ffaf8f7e503bbdea628123a8079ea86e44ba770322f3d"
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
