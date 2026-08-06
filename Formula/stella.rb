# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.127 / @SHA_*@ placeholders below with
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
  version "0.6.127"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.127/stella-0.6.127-aarch64-apple-darwin.tar.gz"
      sha256 "fd4af65f7bc231958804da50bb07778956da8f8a6236b49cf1ab8a9622b95c43"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.127/stella-0.6.127-x86_64-apple-darwin.tar.gz"
      sha256 "d43a7bbfbcc4bf4f64e114159a39d3d8dc09fdd98de25d6a9a614c2bbb8fefab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.127/stella-0.6.127-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "66259a8048d8c8505d145a27d5ea02f785b4d36c98fe6fc539427bba0dd70b36"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.127/stella-0.6.127-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f1eddb80c316d1b09f5da2b5512348aa767e60b027d22591e3f0f1180ed3bbb2"
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
