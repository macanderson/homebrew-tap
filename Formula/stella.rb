# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.366 / @SHA_*@ placeholders below with
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
  version "0.9.366"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.366/stella-0.9.366-aarch64-apple-darwin.tar.gz"
      sha256 "6ba69c365608636a08dbc9f3c1847a712c083f1bc159b3857b187e2bb2fbe424"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.366/stella-0.9.366-x86_64-apple-darwin.tar.gz"
      sha256 "ae551ed0275e43975af214d6f393d66b62faaf2515cfad69254ef6fec3b8ffe8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.366/stella-0.9.366-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9cc681a389a8095e9413e74ba2f7c4a822a982d6336f774bf680e362326a700f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.366/stella-0.9.366-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "36f849578cb3282af83c06381a2a5c8be078436b36bc32c92bb2cbac331fcf5a"
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
