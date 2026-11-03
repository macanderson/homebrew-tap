# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.506 / @SHA_*@ placeholders below with
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
  version "0.9.506"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.506/stella-0.9.506-aarch64-apple-darwin.tar.gz"
      sha256 "2a0ad870562f3e270a2c59ef6796f94085146f20e63d5c9981e42866e8b0fae1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.506/stella-0.9.506-x86_64-apple-darwin.tar.gz"
      sha256 "9d20c35850075c60663a8ce573abcfe28aff11a67d65cc3a8073eb872284f04d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.506/stella-0.9.506-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ebf15f913cfc07072bddc9ec9ee529639e23dec7700b144a7a6098bd6ebbe804"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.506/stella-0.9.506-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "831195b9ed8f6d86b00dcfb8f93ba55edbb486b5aec256b3bb18408c6bbbe52a"
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
