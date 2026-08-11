# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.42 / @SHA_*@ placeholders below with
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
  version "0.8.42"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.42/stella-0.8.42-aarch64-apple-darwin.tar.gz"
      sha256 "8563736b9483aa20de68a66c87cbe10161bbeac18fa6196f656ef3be874085d3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.42/stella-0.8.42-x86_64-apple-darwin.tar.gz"
      sha256 "3e0b4c3e25e0ab63340b11f1b34b70d7b7c649a3a20a36cd72b7a4b5023f4746"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.42/stella-0.8.42-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f92c364e61dd32d42c9d987678fa41be81e0643aae57000478843f50920a6327"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.42/stella-0.8.42-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "db0a81533169287365133f40c30e7f1911bafc43d73dcbeaf7552682fd95a63a"
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
