# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.27 / @SHA_*@ placeholders below with
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
  version "0.9.27"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.27/stella-0.9.27-aarch64-apple-darwin.tar.gz"
      sha256 "af29fee118ccaa23bd416ba59a106f7176098cfe00fc2baf1b1617a5ca539de2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.27/stella-0.9.27-x86_64-apple-darwin.tar.gz"
      sha256 "2324cc05371e489e267179b05ae5f6aa89a1bd2934ec8e3305babc1eb53e91ed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.27/stella-0.9.27-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cca7aea9651d99ba85636977d07decc8a0fd4e3c95bff250f8d7d12a71067aea"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.27/stella-0.9.27-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9bd43097204573e92cd92690371d73155367844b44b84fc60ef31bbbec13990c"
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
