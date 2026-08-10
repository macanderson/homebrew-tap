# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.22 / @SHA_*@ placeholders below with
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
  version "0.8.22"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.22/stella-0.8.22-aarch64-apple-darwin.tar.gz"
      sha256 "aeb6599f7784c4e70378897dd5a3c00ddeba7070ea90f238af2dd19729dbb5a3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.22/stella-0.8.22-x86_64-apple-darwin.tar.gz"
      sha256 "e0d9bdf4b68a3f16501be25b9b8fb1cce9dd6a534d024d327dbfa940ae394fc2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.22/stella-0.8.22-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b5044ecacb05a35ba2535d768e427e1f049dfd61337a4fff3e62c99e4532c7a4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.22/stella-0.8.22-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1726ed0d7d3e1bfdc12681f72ac69e4447e3729b5b787d54c5177445877265aa"
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
