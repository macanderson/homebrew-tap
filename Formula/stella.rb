# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.39 / @SHA_*@ placeholders below with
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
  version "0.9.39"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.39/stella-0.9.39-aarch64-apple-darwin.tar.gz"
      sha256 "9c78e93ef738e6134ae194e75dadb57714bf62015aa538ca73a0c0e47612c9b8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.39/stella-0.9.39-x86_64-apple-darwin.tar.gz"
      sha256 "a2f18cc08fd5ec4ebde24be56f78e9e7fb2a86a199d117b8a5e1d76e7a8b2799"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.39/stella-0.9.39-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "364ed1a7d1aeb65eedeb777a028e614ad5d9471cd87d28a98dccef38cd059ca8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.39/stella-0.9.39-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "928af34d1e362b05226f1994f500e9405d62e3edaa2a5c0c1f72561b72cc2e5c"
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
