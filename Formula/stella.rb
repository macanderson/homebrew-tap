# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.318 / @SHA_*@ placeholders below with
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
  version "0.9.318"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.318/stella-0.9.318-aarch64-apple-darwin.tar.gz"
      sha256 "4e21fa6e3769e46adbff46b5980fb433983f05a45d8c6a6f445810cc2a6e1437"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.318/stella-0.9.318-x86_64-apple-darwin.tar.gz"
      sha256 "d72ba24a0cdffb6b1410e5198a53338a60f387e2a16a4f38134d3b346b9b9d03"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.318/stella-0.9.318-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "23f91c41c47e2997a226ead11e7324d38e92822ba60bb99bde22017f0a75aa0c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.318/stella-0.9.318-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3e4ce087dc54cb1898d65a37752a80421611b31ff58cd32b1b2a05e4c6d3a8bb"
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
