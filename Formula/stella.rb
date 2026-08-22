# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.132 / @SHA_*@ placeholders below with
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
  version "0.9.132"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.132/stella-0.9.132-aarch64-apple-darwin.tar.gz"
      sha256 "1f2e16313aa072af93022b9093251effacdc6b5b358e3fa5b5f289518b9db2a1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.132/stella-0.9.132-x86_64-apple-darwin.tar.gz"
      sha256 "b1f641eb906b0c77a08c48278b4d04a0d99a8f7517928e101ea284a66d02b366"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.132/stella-0.9.132-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dcfa84c4f96737a4eb62a67826852c9c193b24e8ca29e027298993ed7eeaf909"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.132/stella-0.9.132-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4a395e518e2470202063edb3142c984fbf4ef24501da12bd1a5cf3e7ba838765"
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
