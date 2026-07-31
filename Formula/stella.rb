# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.32 / @SHA_*@ placeholders below with
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
  version "0.6.32"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.32/stella-0.6.32-aarch64-apple-darwin.tar.gz"
      sha256 "504c8a427dd1a0b934faacd6dd2e0ec6a99d58240a9a0e44736407369eeb7620"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.32/stella-0.6.32-x86_64-apple-darwin.tar.gz"
      sha256 "dac12ea7def2ae87dbc9494782424f146b0379e40ba514da720b5ccccd2e12b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.32/stella-0.6.32-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "14347f32ef6e0068867702394a32356cdbb3d16e15731afa15cdcc66f7256c3a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.32/stella-0.6.32-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f90d6ac4935b747e7243b3f506d000a9c4802bf9af5fdaf65a7328299afcc0e8"
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
