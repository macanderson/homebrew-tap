# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.45 / @SHA_*@ placeholders below with
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
  version "0.9.45"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.45/stella-0.9.45-aarch64-apple-darwin.tar.gz"
      sha256 "283f314526460e8b116c36b73aacd17471a9c5b027321772f272102e0eb5a8f4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.45/stella-0.9.45-x86_64-apple-darwin.tar.gz"
      sha256 "82c7171667a354da44206956c9855de4c54db675664e3270b9b323fbc8bd263d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.45/stella-0.9.45-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a86d598ef3f83927466e71e0812fe725251c0a3a096d2ad5df17c4ff1f88a392"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.45/stella-0.9.45-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8d5e56f832d882e59feb60826dc913daf878bfb0a05497cbd51a20e1262017d9"
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
