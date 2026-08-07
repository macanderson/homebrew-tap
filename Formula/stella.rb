# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.134 / @SHA_*@ placeholders below with
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
  version "0.6.134"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.134/stella-0.6.134-aarch64-apple-darwin.tar.gz"
      sha256 "ca14905f0f186fccdb7c887cf4ca14c614172dd2e0a43cc4780d8cdd40fb3458"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.134/stella-0.6.134-x86_64-apple-darwin.tar.gz"
      sha256 "f9da71e24a8157c88fd5efdd560d772109fffbd1b3f73f6af881d4b2efd3d34a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.134/stella-0.6.134-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cb27982c06309f60a9e4af2d2a576ad0fed9414a03a4a5e9043933b95b25441b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.134/stella-0.6.134-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0e86bf9915d9d473e3e7408b766037fac651b984cae0e1afcd1325204112ff26"
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
