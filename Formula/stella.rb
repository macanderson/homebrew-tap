# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.60 / @SHA_*@ placeholders below with
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
  version "0.9.60"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.60/stella-0.9.60-aarch64-apple-darwin.tar.gz"
      sha256 "58bb7efdcfd379ffb02c6eabca63dc750e55760f7291fd0ac9896dfa87c1c876"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.60/stella-0.9.60-x86_64-apple-darwin.tar.gz"
      sha256 "ff160db547ea1d2d201ac9493c1547b9f157b3a35abad095994fa174867bb0a6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.60/stella-0.9.60-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6d9630a1eba9c8a749bccac2a38f3a1f46e1679250a3d1febaa8d54365302fed"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.60/stella-0.9.60-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "382859eb737a854f4d0ca2e1f57f88a7a6247aaf67c9567e5af738bf050de069"
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
