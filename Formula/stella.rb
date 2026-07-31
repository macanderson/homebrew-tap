# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.28 / @SHA_*@ placeholders below with
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
  version "0.6.28"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.28/stella-0.6.28-aarch64-apple-darwin.tar.gz"
      sha256 "75428418bb1936e47c2dc11c4c0862f5fc1d75bf4aa69a4a5773a5f4d817e3e0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.28/stella-0.6.28-x86_64-apple-darwin.tar.gz"
      sha256 "ae9b40a0ae63adfbc0274d45f929cbcffcb7701c23cfd6aee37904a075690e91"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.28/stella-0.6.28-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ff223c0b42fbde5153a84567bbc499642393fb041b04d6155861beccebb02825"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.28/stella-0.6.28-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0e4ec94a82676887c61dd4d8a01271f45c3107b9319af62a2b4fba5c12a26c33"
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
