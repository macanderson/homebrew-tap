# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.47 / @SHA_*@ placeholders below with
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
  version "0.5.47"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.47/stella-0.5.47-aarch64-apple-darwin.tar.gz"
      sha256 "8f7de830d828158beb8a8efda5008a871361bd7dacb8e7441d3c79ad25753cfa"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.47/stella-0.5.47-x86_64-apple-darwin.tar.gz"
      sha256 "160780f1cbb84bcb01392b985fb1cb4e568dbc08edb067b2863797bccbae5bad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.47/stella-0.5.47-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f3cd8d29cbe4b04e7cc62458103ad5d46832bf5d88f0aed0ad34d321e755008a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.47/stella-0.5.47-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cc433c7bb0c61a27028e5fce26bcb04bc4c2fdb4c695d8e07346c12da60ab386"
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
