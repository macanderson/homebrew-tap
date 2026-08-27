# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.265 / @SHA_*@ placeholders below with
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
  version "0.9.265"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.265/stella-0.9.265-aarch64-apple-darwin.tar.gz"
      sha256 "f738b6356dccf35f0239aacd532c604fb761a47bef995a4282a1d4a0de7e9e00"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.265/stella-0.9.265-x86_64-apple-darwin.tar.gz"
      sha256 "5123cf253b70787601c32b8f2ddaa282e5c226306845d8066c7d44915308de1d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.265/stella-0.9.265-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "65c10ed16dfc575a5122555e465f11b77119ebceaade7744fc15d3064838fc70"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.265/stella-0.9.265-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6e3038c2722cf2c621bcde1fd27de1f91a634b87e3daf683cacfe84528942496"
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
