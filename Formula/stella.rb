# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.446 / @SHA_*@ placeholders below with
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
  version "0.9.446"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.446/stella-0.9.446-aarch64-apple-darwin.tar.gz"
      sha256 "16cbb56ab805bd119628a25514d29d895e7ee26942f760c880bc697f0d4fcd81"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.446/stella-0.9.446-x86_64-apple-darwin.tar.gz"
      sha256 "1a60827b8176287b541bca2d4bdcdeb72ebc37d68423d79a94de2fb1f7489dc2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.446/stella-0.9.446-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "30c56cb759dbb7f5c34ba9d17d0c9c8f4dc4b8afc372d37e80766991aecae608"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.446/stella-0.9.446-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0e84506ba9123cbb7a427c7dd3e3429bba2dbe260753ffc9e21ef6ad54cc74b8"
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
