# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.45 / @SHA_*@ placeholders below with
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
  version "0.6.45"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.45/stella-0.6.45-aarch64-apple-darwin.tar.gz"
      sha256 "c5ba4459464ad11d6ff1dac0fe4a95997149886d1d6c947da664ce075faa8f3b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.45/stella-0.6.45-x86_64-apple-darwin.tar.gz"
      sha256 "e360bd745e4a26e32a484ef766d7e190e86adb5c6c7d57842bb869e35a8f18a3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.45/stella-0.6.45-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f4469a52779c2f5b62ab09a71ec8e0183c2c49e2b8b020b2fe320b04419d32be"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.45/stella-0.6.45-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0fc8fac9159809f1f91cfa83f9fc50e23f777c90ec652e7c80485719f50cba49"
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
