# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.341 / @SHA_*@ placeholders below with
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
  version "0.9.341"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.341/stella-0.9.341-aarch64-apple-darwin.tar.gz"
      sha256 "d5d7011614345c8dcd2bdf3cf12bf52a2a678a664241ebd8b6cf767bb5ef1f0b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.341/stella-0.9.341-x86_64-apple-darwin.tar.gz"
      sha256 "7f0fa4704c32e46b93431d6d7e4a37cacc5d4dd5e6f9708d8ce6da0cc748cff1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.341/stella-0.9.341-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0db8d8e74c583305a40a1b781f77d4c3b732bb4f41710c3074dd1e034e4c1713"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.341/stella-0.9.341-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "974a5ad88cb4e6d62c1f0d02b07ffa8c54b301f4c29a7c85341b312bc1d08c43"
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
