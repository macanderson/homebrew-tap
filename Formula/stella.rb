# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.5 / @SHA_*@ placeholders below with
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
  version "0.7.5"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.5/stella-0.7.5-aarch64-apple-darwin.tar.gz"
      sha256 "e04304cecd16ec060906db16c4b8b4ac899f9ef073b89284ec9b3abc8eba9966"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.5/stella-0.7.5-x86_64-apple-darwin.tar.gz"
      sha256 "4ea1739433d22109856a5b29a648283d9d159261c292148ba9030efaa478543f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.5/stella-0.7.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ff1c3b58de77c74ceb192ca54ca8319310398fcdd20344a69f43d2aff6b11ffd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.5/stella-0.7.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2940cbfd0fe9b432eddfb2370788b624c84af10a46a19b7cfa31b7ff84c57c51"
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
