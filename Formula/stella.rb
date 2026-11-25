# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.526 / @SHA_*@ placeholders below with
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
  version "0.9.526"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.526/stella-0.9.526-aarch64-apple-darwin.tar.gz"
      sha256 "96366588f99c45492430d52d46377e6d2055294fc6e9138f12e10e1aeeb7b9fd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.526/stella-0.9.526-x86_64-apple-darwin.tar.gz"
      sha256 "28de1262d4380523b1eb783479519b7da4efa90a21b4da2b00fa5cdce1d42c33"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.526/stella-0.9.526-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7336aaf35dca30606df63521a4602c921378febe110823b27d43cff62c111c88"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.526/stella-0.9.526-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "84a380b1a0baf2445897cee6bba1f2a601dcce5118786463bcd0d3cec5b4a6f4"
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
