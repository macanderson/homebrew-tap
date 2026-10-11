# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.493 / @SHA_*@ placeholders below with
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
  version "0.9.493"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.493/stella-0.9.493-aarch64-apple-darwin.tar.gz"
      sha256 "f5bc88ccda477a8216eb996a3aecc7d7ebd08d84ce49573b0d5815c2449f1a55"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.493/stella-0.9.493-x86_64-apple-darwin.tar.gz"
      sha256 "1e5a91af17c4e448c8343cdac54f619ca8a7d3858fb7d8e69e2e169064319091"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.493/stella-0.9.493-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ddf81cc5d0b62f24d3948dab89fdb741de6ddf717032eaa18d320631ea65f539"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.493/stella-0.9.493-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e1d0c0726a9ee13901b7513ca2bd7883b355c153752cc08afa653cb79bc4d4e7"
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
