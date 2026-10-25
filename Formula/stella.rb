# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.502 / @SHA_*@ placeholders below with
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
  version "0.9.502"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.502/stella-0.9.502-aarch64-apple-darwin.tar.gz"
      sha256 "0835d1f1878c99b9b34e896e95af860317793dd8eef719ecf7e2eea4eb272967"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.502/stella-0.9.502-x86_64-apple-darwin.tar.gz"
      sha256 "a8a2c11af2c3b55d194b121ea416e4d2e7a7c56ac1f0676a48f491e79011ea5d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.502/stella-0.9.502-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "884518207854dff36413006e600abd1147afd614cad4becf4d6697c7e4d424b2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.502/stella-0.9.502-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3260a99eca7f4d8508e5a9b253142a4bca7576484bd3f5108cb747e4092add08"
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
