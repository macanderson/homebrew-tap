# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.527 / @SHA_*@ placeholders below with
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
  version "0.9.527"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.527/stella-0.9.527-aarch64-apple-darwin.tar.gz"
      sha256 "8eb97b74725964ceee44e5f213415a8aa57484a8230989020c4f34854a20598e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.527/stella-0.9.527-x86_64-apple-darwin.tar.gz"
      sha256 "598f5607e2b99f941f9f9b9cf6100010985c1d50597b067ac749d4bf776ffd05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.527/stella-0.9.527-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0990d09419bcdacc8c75fc0bdcabddcb3cd8b1a2ce6ce1c6eabdbb25ec25ddfb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.527/stella-0.9.527-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "661a2596c6f8cdddbea722d2a0b7bc7d3c734631c73de598c1d356d0715d6713"
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
