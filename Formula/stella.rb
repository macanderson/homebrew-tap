# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.37 / @SHA_*@ placeholders below with
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
  version "0.5.37"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.37/stella-0.5.37-aarch64-apple-darwin.tar.gz"
      sha256 "be0069d202588a42bc0e580dc72c6a535d09ad677371333dbaba4db405d2f053"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.37/stella-0.5.37-x86_64-apple-darwin.tar.gz"
      sha256 "6870b80622038fadceda104e1e12772841fe3e8d35248c827a25ef37007c5bca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.37/stella-0.5.37-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "16aa631b0df9c0166b5b9f00c94ae945c5831e9fd15ea5fc85690ee73f87c932"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.37/stella-0.5.37-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "adfa8135f0ee585bc8d9702109ea37d11bf2fbe77fa4bbc3a8c0869174ae50a9"
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
