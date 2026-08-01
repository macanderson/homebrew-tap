# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.39 / @SHA_*@ placeholders below with
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
  version "0.6.39"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.39/stella-0.6.39-aarch64-apple-darwin.tar.gz"
      sha256 "83d3c9f49131fca1c176a98c5902efa3a4d736915d72e3dc4f86bfcdf7f35fe2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.39/stella-0.6.39-x86_64-apple-darwin.tar.gz"
      sha256 "4f167480676467a09b981ad2e63807c491aae43b19d384eed703bc1cc733dab7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.39/stella-0.6.39-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0e13c14b7579d61eb23d5974ee6d622e74bf3980ecba6fd9eb430a4c5f771af0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.39/stella-0.6.39-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "df456c53affe174f73957fe67a564247611a6b5c8cde823f9c28fbd46bb309a7"
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
