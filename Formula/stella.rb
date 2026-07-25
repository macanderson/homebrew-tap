# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.25 / @SHA_*@ placeholders below with
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
  version "0.5.25"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.25/stella-0.5.25-aarch64-apple-darwin.tar.gz"
      sha256 "19dbdd3bee8a869154ef0ca400756710c7a196fd410a987a3d688379b8365b97"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.25/stella-0.5.25-x86_64-apple-darwin.tar.gz"
      sha256 "acc16301866627162a53c252b168c27b93a5df2637bc2060f0ec8659d5a48bd7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.25/stella-0.5.25-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f65455789f8dd6e8e1eac17f28544accb8ac7c9956a2f195c65b29ee37b8a883"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.25/stella-0.5.25-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6aeff5a7b009d3f16edaddcb64039e3709cf0367b87dea27b7157eebe490d37d"
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
