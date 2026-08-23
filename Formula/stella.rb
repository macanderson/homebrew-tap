# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.164 / @SHA_*@ placeholders below with
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
  version "0.9.164"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.164/stella-0.9.164-aarch64-apple-darwin.tar.gz"
      sha256 "65bdc25ad1091cb014dff12e8337bc817653da32de0177defbfd29ffc4a3f3c5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.164/stella-0.9.164-x86_64-apple-darwin.tar.gz"
      sha256 "929679c1e095fa8bb970b36995e6cddc8606f162eba3168a8cf1b6a342973845"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.164/stella-0.9.164-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0bcc56f97e1f2b168a3e3d8c744f9ad33f1d1016f6613afd045bea1edabfb8be"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.164/stella-0.9.164-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5183b56118fef0c722a96b95af9956f848f37d36d251a60d5592c09265746dd6"
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
