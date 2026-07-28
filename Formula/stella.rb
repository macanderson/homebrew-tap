# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.67 / @SHA_*@ placeholders below with
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
  version "0.5.67"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.67/stella-0.5.67-aarch64-apple-darwin.tar.gz"
      sha256 "5bf8aa5d2226de88f316af671505261c418d5c30a35870de6906938094c32ac0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.67/stella-0.5.67-x86_64-apple-darwin.tar.gz"
      sha256 "9661f7ff58368090eb5a6dbc26526d2d04b7ca2fa0ab07be459615f135a2702e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.67/stella-0.5.67-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ed638b1c938ee5a1a5dc46b8dac79758a3a3332f887681138404d73e11c53965"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.67/stella-0.5.67-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e40b25a88f01be0d2b7d1e16b0c0e70233cb46a66bdb533242294593c2265153"
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
