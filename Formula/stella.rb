# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.58 / @SHA_*@ placeholders below with
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
  version "0.9.58"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.58/stella-0.9.58-aarch64-apple-darwin.tar.gz"
      sha256 "78ae30da06531fb4abda4d4967c9b7d09a3e5872d7b72a9cc1af18ee1d4725c1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.58/stella-0.9.58-x86_64-apple-darwin.tar.gz"
      sha256 "02c2650e93e1154c714576b82bfd47c90a2804971890f6345282c5599b7eafb1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.58/stella-0.9.58-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a47fa32c1a74fbd275a335f6cb8cfc25a42108fe3bd12e1f469d20718a097087"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.58/stella-0.9.58-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eb9167a47e972b55f33f4b4bb1ccbe1febaf032e24cadb837c1c70631c52d082"
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
