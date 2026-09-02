# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.306 / @SHA_*@ placeholders below with
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
  version "0.9.306"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.306/stella-0.9.306-aarch64-apple-darwin.tar.gz"
      sha256 "76573e5514a878bfdde53694f74d42390c47e9098cf186fc9c22e4d268cbfaaf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.306/stella-0.9.306-x86_64-apple-darwin.tar.gz"
      sha256 "ce5e19fa4b107fe0ffa8bd4cd113ec8173fdb2a21edbbe2c4b079dfd0e9b6b4d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.306/stella-0.9.306-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f387f5cbe544fb4f66b8a8b91f85e97e9caac26d91895ad5049b5eb2e9cb4ad6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.306/stella-0.9.306-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "65a7d7d32233221b31182152727f51e67658a82d3362150202fd7c1515652632"
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
