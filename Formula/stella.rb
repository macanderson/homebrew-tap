# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.119 / @SHA_*@ placeholders below with
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
  version "0.9.119"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.119/stella-0.9.119-aarch64-apple-darwin.tar.gz"
      sha256 "c5f962eaccb73849f2e62791bf785c09627953074854c167ed9f9f7a3b0f7e14"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.119/stella-0.9.119-x86_64-apple-darwin.tar.gz"
      sha256 "744e906ac83087c1499e6b0f7d6537e6ff695196cdde8a5e11aa8debe41d5c0e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.119/stella-0.9.119-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e405d60e174366e43d13cc39a2c7f1f43c1bf42674fd1fe128052e42e265f4ad"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.119/stella-0.9.119-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4bae5bc5e4aa5f40e5377acf0f2e92099f8b49f6e0f288190e5355ad67c08414"
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
