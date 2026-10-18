# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.497 / @SHA_*@ placeholders below with
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
  version "0.9.497"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.497/stella-0.9.497-aarch64-apple-darwin.tar.gz"
      sha256 "807fe6f43bffae5ed25202cacdc75ee1fef8c42e5112f19d8f1ba4687ec50b7b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.497/stella-0.9.497-x86_64-apple-darwin.tar.gz"
      sha256 "57d77f34df84e6ca22b66e9629a81ff88c55f02812981ebf6c1bdd44e9e6fbaf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.497/stella-0.9.497-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1f4683185507e56f808fa2bdbe1cdb5c906bb7f36ed342998fe2c0636556e8db"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.497/stella-0.9.497-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "98054104b91a49e4936407fd2aef3a188f421c0411944f89fef3fe0ab5202379"
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
