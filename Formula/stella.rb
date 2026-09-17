# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.425 / @SHA_*@ placeholders below with
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
  version "0.9.425"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.425/stella-0.9.425-aarch64-apple-darwin.tar.gz"
      sha256 "40526bdb433750a7e6425ee62aa083bbea2aeca579676020120357882b267ed9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.425/stella-0.9.425-x86_64-apple-darwin.tar.gz"
      sha256 "164f6bb15bd2bc67838f02f318b13d1b494a1da40f463deaa4488416c2cae399"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.425/stella-0.9.425-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c439538837cfd969b2716e0ef192a3d622c52ab515bc1fa585681a1c9a700f85"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.425/stella-0.9.425-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8b8e5337ccc666db636210f40bf2be96e496b11a7abb5729e043fb400a65625c"
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
