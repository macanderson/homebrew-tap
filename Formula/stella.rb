# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.59 / @SHA_*@ placeholders below with
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
  version "0.5.59"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.59/stella-0.5.59-aarch64-apple-darwin.tar.gz"
      sha256 "ea96b75dfbfdcdac3eb78cd473b020de244b00025383146f2eba8a23600563c0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.59/stella-0.5.59-x86_64-apple-darwin.tar.gz"
      sha256 "59d9689685a7e67ce2a01e6558b2171b485fcb4538d1cf086a51d6a6868ce0b7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.59/stella-0.5.59-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c809fcaccc008f8a1ce5ab01584b7cceaaeafb3b610139ca43cd5d30eb56e69a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.59/stella-0.5.59-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3e0a8484b47290cfbe173a11edc9194410d32ba30e0da3a8d170727b09dd1799"
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
