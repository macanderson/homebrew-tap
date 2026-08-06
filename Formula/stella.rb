# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.123 / @SHA_*@ placeholders below with
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
  version "0.6.123"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.123/stella-0.6.123-aarch64-apple-darwin.tar.gz"
      sha256 "73083dbd1b85bf7b6ace9d04d53fc706a3fd0dc45993049331a97904b9495413"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.123/stella-0.6.123-x86_64-apple-darwin.tar.gz"
      sha256 "e37e337d513832c68602991bceffa914b0b727ca72cbd3aa676f1617ad3d83c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.123/stella-0.6.123-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5686424d003b4aed479d36c81831cf4dc2bafa62b928a5b20656f218d90e3322"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.123/stella-0.6.123-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "62da3dad13102d87ed7e02a9409ab7d2bb99beb54da6629891a3077c6ef4857f"
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
