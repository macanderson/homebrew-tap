# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.121 / @SHA_*@ placeholders below with
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
  version "0.9.121"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.121/stella-0.9.121-aarch64-apple-darwin.tar.gz"
      sha256 "771dff1a3ee91d6d322035d0703c5211c91fe8cd978a65112e2fd58793eb85ef"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.121/stella-0.9.121-x86_64-apple-darwin.tar.gz"
      sha256 "61f8cfb1f947657a514d3c34a783634c4c08d0ec2f3cd2d161d5d0543b422690"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.121/stella-0.9.121-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "53408f52fd72c030c50b4fa500fd4be5929df94f67e2e7530efc0e872ef6023d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.121/stella-0.9.121-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "469fa280bef8c97cc4c3a75a0596ba884fbf4f28ddfab872ec15ef9a781ed1de"
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
