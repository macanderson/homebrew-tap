# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.7 / @SHA_*@ placeholders below with
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
  version "0.7.7"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.7/stella-0.7.7-aarch64-apple-darwin.tar.gz"
      sha256 "bb877e3c672f90731f8e9b40bc67bc7eabc8b51254a779b6c8f7197c2387e7cb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.7/stella-0.7.7-x86_64-apple-darwin.tar.gz"
      sha256 "67929151e9d726adcd5d6bc8fcbe3de93e890b65bc9c13b0dd6a27938d207aa6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.7/stella-0.7.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2cf6b6d8f0bc1e98d0eec0a9c909cf4d794a22b07720db750d77e23cdb0fbf02"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.7/stella-0.7.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "106e2a7505102c1b2ad75261d0758914c6dea5b8a458f9dd29df28e5386761d6"
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
