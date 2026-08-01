# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.49 / @SHA_*@ placeholders below with
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
  version "0.6.49"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.49/stella-0.6.49-aarch64-apple-darwin.tar.gz"
      sha256 "d8713fa6d086bd08d55e92abcecd3b162e079cbe99b0fbabb5fe7fa075b09f87"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.49/stella-0.6.49-x86_64-apple-darwin.tar.gz"
      sha256 "ea9e881c22b838064ac4afcd69a2969c3813cf5d621d25e296eb52ab2d62b4b1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.49/stella-0.6.49-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "304f35ae2fa0754f0bd6a8ff6c8b30fe0c06dadf24d40923dbe9c6cf29f57e8c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.49/stella-0.6.49-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "656f37f1cd1c5d67446033dea9bae1b6337d335f9fe3a9c5047e020703d50434"
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
