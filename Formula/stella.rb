# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.22 / @SHA_*@ placeholders below with
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
  version "0.7.22"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.22/stella-0.7.22-aarch64-apple-darwin.tar.gz"
      sha256 "0a838cea8328eced75ea4f881097b6d8f8202d50bc188e531d5e638a29c8fa77"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.22/stella-0.7.22-x86_64-apple-darwin.tar.gz"
      sha256 "47191f56d9ab19be722f4129c4435fbe1385f606bf7a1f2d153ec9235bd6518a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.22/stella-0.7.22-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e2553211757bccd7432a1bbac7348b2d63942a6d3725f0d0c6512a252c6dd0b5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.22/stella-0.7.22-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "271df4676d7885f5e4bffbf407f9e6b661e50676501dec357be6b43008050b4b"
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
