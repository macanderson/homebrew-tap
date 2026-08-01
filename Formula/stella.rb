# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.62 / @SHA_*@ placeholders below with
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
  version "0.6.62"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.62/stella-0.6.62-aarch64-apple-darwin.tar.gz"
      sha256 "a0b11ada7de5f31288595610a42c4cfde4dcfefc163acf0534c941c5ec5bb0d5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.62/stella-0.6.62-x86_64-apple-darwin.tar.gz"
      sha256 "7ab3a3ed5a2d5a5dcef7827a3b8271b39f64a42eb3d13546f049d04f25cb8189"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.62/stella-0.6.62-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e9295b8686e2fd0f294c94a9692c14e64d73afb399707f03b54079f78dbc38e2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.62/stella-0.6.62-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b4777ecca2b3707ed1836161c743636694c3612c08876808b42755922882e34f"
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
