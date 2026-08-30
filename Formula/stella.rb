# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.294 / @SHA_*@ placeholders below with
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
  version "0.9.294"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.294/stella-0.9.294-aarch64-apple-darwin.tar.gz"
      sha256 "f455fbe71389323157a2c2d11b1e55d8b026e3ba452061119d97040a594d11dc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.294/stella-0.9.294-x86_64-apple-darwin.tar.gz"
      sha256 "2d4639ff0927258f9ec3040a387811cfc32341d83f5e8cf1bac3b097c5cc89ba"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.294/stella-0.9.294-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "913f3c721ba224149b42c95ec3041ea9fcc3cb381bc7c01f81d8bb4283a0d69e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.294/stella-0.9.294-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "492845789ed5aa3b9922b2e3f9f52b8dff0683f6e6e0dea986557268d7679361"
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
