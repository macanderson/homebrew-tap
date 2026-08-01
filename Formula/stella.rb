# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.33 / @SHA_*@ placeholders below with
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
  version "0.6.33"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.33/stella-0.6.33-aarch64-apple-darwin.tar.gz"
      sha256 "861321118dd965bb4c1fc72727b9ec006c4570707a9e67d73a920b2a042c444a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.33/stella-0.6.33-x86_64-apple-darwin.tar.gz"
      sha256 "8d6ea9917ff7b153c1c4f94c0a3bb7eedeaae3542bae304532c46b82d10495f1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.33/stella-0.6.33-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ac75772c29f00ca31605d8425022532e737119aaf036bb65d52fbc590217cf8c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.33/stella-0.6.33-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b1e782f885d033a9997538154dbe3d3ada0c6917a6bf9ff67d112e2fb790402d"
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
