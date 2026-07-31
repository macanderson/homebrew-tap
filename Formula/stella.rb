# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.30 / @SHA_*@ placeholders below with
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
  version "0.6.30"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.30/stella-0.6.30-aarch64-apple-darwin.tar.gz"
      sha256 "68a6f27da8650de4728a5253fe82c16cb268e16b001ed21b42018d744020859b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.30/stella-0.6.30-x86_64-apple-darwin.tar.gz"
      sha256 "69031e38a8da40c69375104c1a0aebd482d057b1a5406bd05204015280320c3a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.30/stella-0.6.30-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "96bedd20a918f3a5ce780efe96617abdded7ac43b7a9187dd794595c2d093509"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.30/stella-0.6.30-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cddf6049b071590fdbbf4a66e4f3077552c31a0fccc3eb17e257119196f89f6a"
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
