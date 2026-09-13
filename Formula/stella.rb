# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.424 / @SHA_*@ placeholders below with
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
  version "0.9.424"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.424/stella-0.9.424-aarch64-apple-darwin.tar.gz"
      sha256 "9ad6d5e0016200913ece65e9ff4ea29e3186bc0a208d9cc02bd7c10babd6c9fb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.424/stella-0.9.424-x86_64-apple-darwin.tar.gz"
      sha256 "f4481eff6d989332ed5e9337e0002cfcca1f438fd01f4c8045de3468a8d48783"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.424/stella-0.9.424-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b8c7e5e28f2b70b44befe0f7c61855499dddb81c679356b36fcdc20996b5a3ce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.424/stella-0.9.424-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d852ca694c517a5e29ebeba4d7b9bf710e1c5d3f1ff5ed0194a2b36dd5e97b02"
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
