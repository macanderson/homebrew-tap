# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.245 / @SHA_*@ placeholders below with
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
  version "0.9.245"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.245/stella-0.9.245-aarch64-apple-darwin.tar.gz"
      sha256 "97fa86cdfaa33ab05471ff348c6f8991bbee92bd473378597d24c9ba6b18d1f7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.245/stella-0.9.245-x86_64-apple-darwin.tar.gz"
      sha256 "276dfc075ac87a1bf02eac759ef01f10d7380faf6c9fbd89576cbf2136fd7bbb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.245/stella-0.9.245-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3e3a52d19e0caac25333707da25dfe302b0127a6fe72deb06a8f3993f14210b6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.245/stella-0.9.245-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "98dd22c5754525241dc808cc45b40363ba32111761bcb1f0ccea816abe672f93"
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
