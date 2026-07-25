# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.24 / @SHA_*@ placeholders below with
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
  version "0.5.24"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.24/stella-0.5.24-aarch64-apple-darwin.tar.gz"
      sha256 "a4cf58620d34a79c3fb1f66e6552da9689733a40f803dacc41fd4ea337811389"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.24/stella-0.5.24-x86_64-apple-darwin.tar.gz"
      sha256 "1bc6f913025c3c7fe068b2c7118eafea12f3ea0560fd96e89531dfe0a089419f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.24/stella-0.5.24-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c139bf21c01abafeea97216e95c3802cfcb98eca35528f76c4e85a2cf3a823cd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.24/stella-0.5.24-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "019dbb1795819d343aae97aaf64af910d603c14017236711c038c63b45d346d1"
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
