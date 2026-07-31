# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.26 / @SHA_*@ placeholders below with
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
  version "0.6.26"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.26/stella-0.6.26-aarch64-apple-darwin.tar.gz"
      sha256 "b4353be594cd60e672f505c27951737ea11ff2ef7683db00d79c516509733e5b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.26/stella-0.6.26-x86_64-apple-darwin.tar.gz"
      sha256 "2e3ad9893bc84bcb516ca4dfb28b59f04ec448b141c500b4f4300a92f2ace56d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.26/stella-0.6.26-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3e219d361c8d4119aeee4c721626c07b0b0dd01874ca1abbfd14001ed9755d23"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.26/stella-0.6.26-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e5f76d2a9dac797dddce6cf849aa7c5373ca1ad8b1360bd58dde7869c3aa7b26"
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
