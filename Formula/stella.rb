# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.20 / @SHA_*@ placeholders below with
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
  version "0.8.20"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.20/stella-0.8.20-aarch64-apple-darwin.tar.gz"
      sha256 "fff2b0802d8c70ecd9b5e50373f1102a65f9761fec77e9bc4464a7134642a24e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.20/stella-0.8.20-x86_64-apple-darwin.tar.gz"
      sha256 "08d0bbef691b390cfd9a04a153ba2b1b05cffdfa76b899e22048e82f32cc3f61"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.20/stella-0.8.20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "87c59af37113d2ef6de9d52405ded8b4e7412a8f2847e74509ed72cc3c68b4ee"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.20/stella-0.8.20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e4a51f4a0573cc411803f96edbf270c2b2a11c2852ee54af604201f31d90679e"
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
