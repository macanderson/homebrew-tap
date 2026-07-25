# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.18 / @SHA_*@ placeholders below with
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
  version "0.5.18"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.18/stella-0.5.18-aarch64-apple-darwin.tar.gz"
      sha256 "6d3922d1577ea482dc23c9b6f4cfe92213977f1d54b2d01d67abfc1f089989a9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.18/stella-0.5.18-x86_64-apple-darwin.tar.gz"
      sha256 "0ccacfdbf558c6898b84d56739faea14be854fa8cec3148b892fc937a980af85"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.18/stella-0.5.18-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3874977ad5f72aad889fe187c8b5ad0460895085b9f130f71fec9a69ad33fe5d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.18/stella-0.5.18-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fb9413b21f54aeee1fbf46c8b3e2a3991efc16d171aa61729c55635c42e4a49d"
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
