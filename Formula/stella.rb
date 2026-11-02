# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.503 / @SHA_*@ placeholders below with
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
  version "0.9.503"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.503/stella-0.9.503-aarch64-apple-darwin.tar.gz"
      sha256 "a0312ee17e0fa092855d16b26837f236fb1f2f901acb2cd7ff82f6b4ed91d615"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.503/stella-0.9.503-x86_64-apple-darwin.tar.gz"
      sha256 "848d62249c30f8f467efc5d5047e54df10b74d291d997c3d47be0634600981d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.503/stella-0.9.503-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cd9d6d1e8f5035040066bbfc489b37c969ceeb4f79e9496f9a95570cdb45fbf4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.503/stella-0.9.503-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8a4950dc4e9f2ba29067cd3b3f80b8252f45afbb3b306d864c15d0bdf069b2f9"
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
