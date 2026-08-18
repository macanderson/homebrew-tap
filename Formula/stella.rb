# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.100 / @SHA_*@ placeholders below with
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
  version "0.9.100"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.100/stella-0.9.100-aarch64-apple-darwin.tar.gz"
      sha256 "9a04190ed7de4c0fe6a4244f48db2e0350e5fd974a18422c2af8b7181c90f42a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.100/stella-0.9.100-x86_64-apple-darwin.tar.gz"
      sha256 "091fa2e84bf6952664a2a21de772c3dee8a82d740991882d43cc9ad3fd956927"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.100/stella-0.9.100-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3b9895f0d8e4582d7d09b15a7c76c3da3cb97235940c3b490b856de49a2ddeab"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.100/stella-0.9.100-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5e2ecb3b9579eca5fe230d4e7e47f799d0bcf810f5e9af24411b92b754887750"
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
