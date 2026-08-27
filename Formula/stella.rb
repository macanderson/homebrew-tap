# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.256 / @SHA_*@ placeholders below with
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
  version "0.9.256"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.256/stella-0.9.256-aarch64-apple-darwin.tar.gz"
      sha256 "3a15dfde93917ef6486526b6882754df54aabbe824606d1a970477f283829161"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.256/stella-0.9.256-x86_64-apple-darwin.tar.gz"
      sha256 "4f466336ac6e3401c3dbbd9f9b743866e4c23b4407b733483563c178c69869b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.256/stella-0.9.256-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a4d6e8ece6725358b548cabe51895642d5c5fac72589bd5b596806a42d83fcab"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.256/stella-0.9.256-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f9b651ce0db76ea36758a686b92ceaa1d3b5b64a8ad69bc984826fca98bd4c9e"
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
