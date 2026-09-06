# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.362 / @SHA_*@ placeholders below with
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
  version "0.9.362"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.362/stella-0.9.362-aarch64-apple-darwin.tar.gz"
      sha256 "768cb7d412fbddb7de32e0c29861e2c36cac8bc182440853149eb37a399b0378"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.362/stella-0.9.362-x86_64-apple-darwin.tar.gz"
      sha256 "d2193a8107b968c88840445d165cef18b6dd89402c5ba313db96b1eef9819e93"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.362/stella-0.9.362-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6c877e8291ddeccfee4fe6fb57201131433afbe47c6ae34074bf0a8a8ff4a912"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.362/stella-0.9.362-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ef0b0abddbb80fe589a0d60020419141d1a63da9014aa74409bdfaf9534c5b8"
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
