# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.20 / @SHA_*@ placeholders below with
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
  version "0.6.20"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.20/stella-0.6.20-aarch64-apple-darwin.tar.gz"
      sha256 "5c2b536e68ad08839f492151d5a4be9a3de240a99eef4a19ab556bba5dd0a5f8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.20/stella-0.6.20-x86_64-apple-darwin.tar.gz"
      sha256 "c2a3097e48292831e1f2a30a0d2635b53f0d73654cc9e91a0950ca8e6cb2c8bf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.20/stella-0.6.20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1a98ae053f9b0776ed01733d46ec9ae8c18c163c7c0761b057944e44947da4c4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.20/stella-0.6.20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "05a45b0f71d2595805d456d1c415f1e7ef8615715ec5e93ef99a001945cdec6a"
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
