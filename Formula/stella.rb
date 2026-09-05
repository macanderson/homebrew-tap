# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.328 / @SHA_*@ placeholders below with
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
  version "0.9.328"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.328/stella-0.9.328-aarch64-apple-darwin.tar.gz"
      sha256 "19556950b05c2a2880e9d0e8905fd16ed7c47674906e35eb1b42c9e55ef11025"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.328/stella-0.9.328-x86_64-apple-darwin.tar.gz"
      sha256 "736d490fdc348408626ce7fed83425600cbbc043c214d8b37d20d131470db5d4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.328/stella-0.9.328-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f15e5c0f9b369118acd19159656ee85c8dd82a472c580ddd491e70d486e90d25"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.328/stella-0.9.328-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3b7bb6c18bd8f0b3f5fa32ce272cf035c024eeb72c7815d95d1564260939cc68"
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
