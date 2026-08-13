# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.37 / @SHA_*@ placeholders below with
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
  version "0.9.37"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.37/stella-0.9.37-aarch64-apple-darwin.tar.gz"
      sha256 "11fccd76e4f76a5515b7bf9064567cd6b59243b9fa4981e65b29f3f6bd1f185c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.37/stella-0.9.37-x86_64-apple-darwin.tar.gz"
      sha256 "922f9f998b46b74008b0809e593e2d305b2f0aecf2937dcd7b812ecdfe1346c4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.37/stella-0.9.37-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6b168122835c55801110c23544ab8dea5fad0560cea205defca931960903171f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.37/stella-0.9.37-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "27c9b933536b5d9d2eb90bf24c405c6dc435d2ccde556619b685fbf12636f381"
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
