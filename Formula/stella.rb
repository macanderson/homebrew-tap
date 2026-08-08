# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.23 / @SHA_*@ placeholders below with
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
  version "0.7.23"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.23/stella-0.7.23-aarch64-apple-darwin.tar.gz"
      sha256 "abd4d93c7054f5978310905bed46a6141609b6a7f39f42b0042e1beed77c6c95"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.23/stella-0.7.23-x86_64-apple-darwin.tar.gz"
      sha256 "02f981c434aa6e9d2d4ecf7d7808444bad2350af38e1e9dbf1b673bd15d631df"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.23/stella-0.7.23-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3417b0edd503b83a862639de24724490ae27c79958fb84596939e3e22b213280"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.23/stella-0.7.23-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9110f3952dc948d1f3c382483638639b83d9fa4174085c78ddf9170ac84b24dd"
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
