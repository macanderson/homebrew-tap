# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.381 / @SHA_*@ placeholders below with
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
  version "0.9.381"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.381/stella-0.9.381-aarch64-apple-darwin.tar.gz"
      sha256 "c73ec5ac3d8bf4676988ffb433f9084230cc2c7fb70372f7ad19dc91abab05af"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.381/stella-0.9.381-x86_64-apple-darwin.tar.gz"
      sha256 "84da53f823221db327db24fc2ee0fde112a66b0eacfeb41515b6ebc770a12d05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.381/stella-0.9.381-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "389f3ab2a11968c5398eaee2281e7453c95e286743c5aaf05d297d7ba354d62d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.381/stella-0.9.381-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "73dba7c8dfaefedc0929c6e39d712abe07f6dddb77633aede56234dbd1de7679"
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
