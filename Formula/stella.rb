# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.26 / @SHA_*@ placeholders below with
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
  version "0.5.26"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.26/stella-0.5.26-aarch64-apple-darwin.tar.gz"
      sha256 "5044cdc504d6e4412bc9858d8b90731600a0e5edb39af641228618acd809b450"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.26/stella-0.5.26-x86_64-apple-darwin.tar.gz"
      sha256 "7cc1d2f9af8bc68680abb8d85c02f309338b894f5115be69535e14174ce981ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.26/stella-0.5.26-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5d221031f8bf33578f5d0e34306c2442b995f4ef568bd544b29e034f076301a7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.26/stella-0.5.26-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "37cdffa753aaf396db1e2f71b7ec040f151cdcc09b72e6f122c3461f86c6e0f2"
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
