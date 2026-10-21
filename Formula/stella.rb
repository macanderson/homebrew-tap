# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.498 / @SHA_*@ placeholders below with
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
  version "0.9.498"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.498/stella-0.9.498-aarch64-apple-darwin.tar.gz"
      sha256 "03fef79a3a9273adf7ba575023b2b95d7c728425c6083e481667d97ce1896a9f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.498/stella-0.9.498-x86_64-apple-darwin.tar.gz"
      sha256 "677436b93990bc464f9b0b405577472bb8931beb527b2b7d810f42922f2ce7f3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.498/stella-0.9.498-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b704cda0e25541e39ae3ceff26dade52c0fbd86baef785a3479847374c928bef"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.498/stella-0.9.498-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5fa1ec3908d62d834a6842112e097853617639989fb18dee9bdd72d3bed43886"
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
