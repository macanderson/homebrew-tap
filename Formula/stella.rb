# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.54 / @SHA_*@ placeholders below with
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
  version "0.6.54"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.54/stella-0.6.54-aarch64-apple-darwin.tar.gz"
      sha256 "660973c22b08a43e2b3100e7566427389853ca7d0d6a48a1f2666266b77ff804"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.54/stella-0.6.54-x86_64-apple-darwin.tar.gz"
      sha256 "38b537f9d7d96166ddccef8bb39b2bea4c6372c78f89f8771c90e3a562b4677e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.54/stella-0.6.54-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "adb5f61f0f0c2473f4f191869b9b37f92ee21470c1c7185ea43a3c9f8b3222b0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.54/stella-0.6.54-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b4c6ec4df7133e987ccbc2f1fd2ccdb906160213a99e88d5e21e433d3214d532"
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
