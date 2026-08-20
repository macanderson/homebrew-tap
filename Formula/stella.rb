# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.117 / @SHA_*@ placeholders below with
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
  version "0.9.117"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.117/stella-0.9.117-aarch64-apple-darwin.tar.gz"
      sha256 "ec14c322e89413b705035b3a4dbfbbc36d11edbbd3692167ae4eb113c6356cce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.117/stella-0.9.117-x86_64-apple-darwin.tar.gz"
      sha256 "9d58a5dc0a1a3b67b0cc4a1a60e431d78eb469c9871c1e43bdb4d6bfa070f1ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.117/stella-0.9.117-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c41cc2fd8ef2c940e65d7a0b796addda2efe4377a342c00e139d78c7186bbbda"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.117/stella-0.9.117-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "655f7cabd9c49751d55ed9f8ef0c4cd9243c5849a2e6b79c9eed390ecece9385"
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
