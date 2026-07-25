# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.21 / @SHA_*@ placeholders below with
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
  version "0.5.21"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.21/stella-0.5.21-aarch64-apple-darwin.tar.gz"
      sha256 "a6ee22a544cbea3271e88bee2729985c3a8103d12d680e36f13a15033fa61f9f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.21/stella-0.5.21-x86_64-apple-darwin.tar.gz"
      sha256 "d358a5b36f0c0978ffe318c65962e7c9bda5fcfe9f513c0a711f6ee9df837fd5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.21/stella-0.5.21-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "58249a6a588f91d583b682cc79eb9b21f560426ea056b51f799819ed417f74ed"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.21/stella-0.5.21-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5d2d7305a39d24a9e70b64834309e634ea55cb07aaf0e657485fda42741ef4df"
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
