# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.466 / @SHA_*@ placeholders below with
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
  version "0.9.466"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.466/stella-0.9.466-aarch64-apple-darwin.tar.gz"
      sha256 "5962dba4c8b7a8db76bb6ea4bbd1d277494c81b7b0b2b19c4843e168a052b356"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.466/stella-0.9.466-x86_64-apple-darwin.tar.gz"
      sha256 "edac61c1903134ef5982fc473a1bc4a16abda9cf435f7cf3b28b8d0c8defd5ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.466/stella-0.9.466-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9436ab98872f43d58e431301c10a4173e84972672adcb17dcdae77667220c7f6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.466/stella-0.9.466-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "57b3d9fd05c0c6f947d0966ba5f1c5b0d9f72f7d3fee8ba0b430f843e354ccac"
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
