# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.24 / @SHA_*@ placeholders below with
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
  version "0.9.24"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.24/stella-0.9.24-aarch64-apple-darwin.tar.gz"
      sha256 "e82c57ea0f9e689f0f5e0e34479346385fac610cf476e419ede6c57771344966"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.24/stella-0.9.24-x86_64-apple-darwin.tar.gz"
      sha256 "10f4a019dd8e91f0a657e107a1a497df11f72db49a75dc51c1a3b8313b2c04c0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.24/stella-0.9.24-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "307c37524f91baa7ce43827dcdb3af6828199acc9b7bdb434ab522f9b2162b32"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.24/stella-0.9.24-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "730c612ec9b99e4f1519a9a6ee198b79ada1ce874e490df96ec4343a61a34203"
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
