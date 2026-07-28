# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.68 / @SHA_*@ placeholders below with
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
  version "0.5.68"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.68/stella-0.5.68-aarch64-apple-darwin.tar.gz"
      sha256 "bfad83d472e3ba4e09e9be94ab8c2f3510e19a9a683a4105ad1573a803d48341"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.68/stella-0.5.68-x86_64-apple-darwin.tar.gz"
      sha256 "11838d2f9750b845f2e9a07e1731ad77e3f0397e4b008d8581e095e3c22373b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.68/stella-0.5.68-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8c64b14a3f646f8c9225767fc659372946074574d8cf5431fe06d0d90d230179"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.68/stella-0.5.68-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "94738f0ea80915cc196cc6bf590cbe5be6105e264f052719d5f22785a16fdca7"
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
