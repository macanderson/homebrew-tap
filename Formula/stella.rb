# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.12 / @SHA_*@ placeholders below with
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
  version "0.6.12"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.12/stella-0.6.12-aarch64-apple-darwin.tar.gz"
      sha256 "51cc9eca3572286b2e92ab358dfbab6718dc39dcf51c627b73b07a550a1659f6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.12/stella-0.6.12-x86_64-apple-darwin.tar.gz"
      sha256 "4c9f11a29e5c2ae62545f5bb81e611544485b2906686b440ee9ac96d71a7b0af"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.12/stella-0.6.12-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "686d6add08797577df21bb301f533e7d0cd06f666b09e7044b4cb0f8d5caf808"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.12/stella-0.6.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "252766c517f02feb3993e1a94c48d3e5067fc44716dacaec0a6f689e32e98c24"
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
