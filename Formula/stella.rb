# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.290 / @SHA_*@ placeholders below with
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
  version "0.9.290"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.290/stella-0.9.290-aarch64-apple-darwin.tar.gz"
      sha256 "ddfd28092c8ebf96512aafea375c1bde20d587f72f01d0fe491f92275822de95"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.290/stella-0.9.290-x86_64-apple-darwin.tar.gz"
      sha256 "5acf01bf1ee882338cd0fe8539a871fdf88732ae98dcd430a5bad9b2a32d6b7e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.290/stella-0.9.290-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a081da8ad754e1f455858c000ba01bf2555ee94a6f0b6f63c88970421096b304"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.290/stella-0.9.290-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "119aa01ee02a170f9d8658d4b0f2bd8520c54e749c31b710c80ad038408be255"
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
