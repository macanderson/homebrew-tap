# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.477 / @SHA_*@ placeholders below with
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
  version "0.9.477"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.477/stella-0.9.477-aarch64-apple-darwin.tar.gz"
      sha256 "f5a17b12c54a971fd199a8d34516a818d41f09d598e8293c57955f7ff896feae"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.477/stella-0.9.477-x86_64-apple-darwin.tar.gz"
      sha256 "762fd97d0045d92d7eee78d1450cd7f2f3a0b4b3c613ea117005d0a514796518"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.477/stella-0.9.477-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "07653b019edd123201a6d0c2334881b639f40d70a4d6c7679f8705867b656359"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.477/stella-0.9.477-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "16d94b6d917463cf27f5c753e511cc62934caa7d1440f8fb69fae60fa66c2941"
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
