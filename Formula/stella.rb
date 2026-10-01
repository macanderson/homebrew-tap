# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.454 / @SHA_*@ placeholders below with
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
  version "0.9.454"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.454/stella-0.9.454-aarch64-apple-darwin.tar.gz"
      sha256 "8cd3f1cafbbd1c149696f912f9e2e6c7ea04303b29104999d57530b350ca593d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.454/stella-0.9.454-x86_64-apple-darwin.tar.gz"
      sha256 "ad44930d986a797b09d21f8188a9fb1c422fafdfbd0b1f3e7433d3e18371cb87"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.454/stella-0.9.454-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "38240de5a993de16a082184b4ffbca4653c2a3280b42e2fdd5d374dbb938ca2e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.454/stella-0.9.454-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4c16b8e984e6bb39a1c10eed6ff31f44e0a69b669fb9de3aebac2aeec68a3c2b"
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
