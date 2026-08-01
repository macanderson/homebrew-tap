# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.47 / @SHA_*@ placeholders below with
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
  version "0.6.47"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.47/stella-0.6.47-aarch64-apple-darwin.tar.gz"
      sha256 "9e3b4c4905e435c9d2ff0f2aa306d5e44e1548420d69e507dd1609902d107b2e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.47/stella-0.6.47-x86_64-apple-darwin.tar.gz"
      sha256 "a81c76849dfd0e812a757a9ecf6e787983ca387ecb702230ba803b3e91e840fe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.47/stella-0.6.47-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f44d3a2fd4fb80aec2c9f4e5c22033ae7613c217bfbd399a6a316c4688fd50bb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.47/stella-0.6.47-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7f724d68efcbb4ab66b2992767970867cb9b97b549bdcf0b0ae3e48159f6edeb"
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
