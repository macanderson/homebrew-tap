# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.438 / @SHA_*@ placeholders below with
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
  version "0.9.438"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.438/stella-0.9.438-aarch64-apple-darwin.tar.gz"
      sha256 "65bafb204f150a2bc00e857903d58f29910f1c6a1a03f4ff3dc36da4db11f766"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.438/stella-0.9.438-x86_64-apple-darwin.tar.gz"
      sha256 "39ff4d1862b967b2da4c0daf74b4cd221ee901009230e0947404087fddaedbcc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.438/stella-0.9.438-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "464a1fbe4ac6e924906214cf3310d185629d903232c08d0f6502ce0ece8d6ce0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.438/stella-0.9.438-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b6cc69985a92afcf23fe9d6d4f47aaf5a870142caef26347a56f7099ac6cad12"
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
