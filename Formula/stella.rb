# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.235 / @SHA_*@ placeholders below with
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
  version "0.9.235"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.235/stella-0.9.235-aarch64-apple-darwin.tar.gz"
      sha256 "8a5873f022d3e9e9ca49ed070f652addd7080b7b978df9577401319ba0c26508"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.235/stella-0.9.235-x86_64-apple-darwin.tar.gz"
      sha256 "600eb3588529557ad7de4b23bf4d5472711906007982819b2ccbf19bb0016c39"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.235/stella-0.9.235-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cf7cd5ea2dcc860f8f638480026b0f66d98913540852409385fee7f29b8ee9d5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.235/stella-0.9.235-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cb226266882492f8d8c685f5cc5a2c63b05fdbfb8259026c98682a6a12e9df38"
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
