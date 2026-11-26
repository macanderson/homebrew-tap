# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.528 / @SHA_*@ placeholders below with
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
  version "0.9.528"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.528/stella-0.9.528-aarch64-apple-darwin.tar.gz"
      sha256 "a1fdae246e2f224bf248e8cf414e40d66710db7858edb317ffb3beec13bb81b1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.528/stella-0.9.528-x86_64-apple-darwin.tar.gz"
      sha256 "453f46a28d23cc09b4106aa6c3cf1e8f7a6e3840140c77e4bc6060f2e246fb43"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.528/stella-0.9.528-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8ba7deb55ca77d57bfe63e44e14fb724e0b306b738828177f39bf9fabd5c2dd0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.528/stella-0.9.528-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2e108c7b35e8063fd1c57b3ece8ca47978b6b30afe42489dcc7cdfbcb1f51f86"
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
