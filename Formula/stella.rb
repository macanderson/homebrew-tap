# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.14 / @SHA_*@ placeholders below with
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
  version "0.8.14"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.14/stella-0.8.14-aarch64-apple-darwin.tar.gz"
      sha256 "1dd8e839ff3c0bbb65f9acdef48bb01025b502ffa03513117a6690bd9269d9e1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.14/stella-0.8.14-x86_64-apple-darwin.tar.gz"
      sha256 "ed93d53766ec8b69c478a179f7c838120265caad39345a27cfdbb79150967160"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.14/stella-0.8.14-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9094d15a41f04244dc0be2e423bd8ecfd458b0ef194c95e162d499fdaeaedff8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.14/stella-0.8.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "324ce724e0625c44687b0bff81cf2a386919e5328fc0c598ffe60a91a6782565"
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
