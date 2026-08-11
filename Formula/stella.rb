# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.43 / @SHA_*@ placeholders below with
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
  version "0.8.43"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.43/stella-0.8.43-aarch64-apple-darwin.tar.gz"
      sha256 "523683b2d337cc4f1077de4c12f9f9b9eb8a67915f0da78a76957462b6961292"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.43/stella-0.8.43-x86_64-apple-darwin.tar.gz"
      sha256 "8a543cda932532ff44f97c535e3109f5e9927de7202e1966ce83aa4d1d4fa44d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.43/stella-0.8.43-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7cfd20d542957e1c7cade3219b2d375a6a47e4d220969102c0203c0b9b047845"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.43/stella-0.8.43-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d3d7ba850338637e51d6dc5d7a9413584211877c09d9a348bcb4844ecba924af"
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
