# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.5 / @SHA_*@ placeholders below with
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
  version "0.9.5"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.5/stella-0.9.5-aarch64-apple-darwin.tar.gz"
      sha256 "2ba755ca1854294f342d20db83fd111a20b453e2148d1f44c40884f5978215d6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.5/stella-0.9.5-x86_64-apple-darwin.tar.gz"
      sha256 "8aca8f09e5e46e8e5b107e1913aee9ecee5ec3218542b5c4d176374c3cf19157"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.5/stella-0.9.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "69e901fa373e80a1d06a711e3bb64fdcbc2ae2dcda4ea579431b494862b6a8b7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.5/stella-0.9.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fa02112dcfd1924ccfac963bf5d20f23ba9d263210422d03400b51d6e718ae23"
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
