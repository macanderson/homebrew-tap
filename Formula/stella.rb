# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.15 / @SHA_*@ placeholders below with
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
  version "0.8.15"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.15/stella-0.8.15-aarch64-apple-darwin.tar.gz"
      sha256 "fc193b445a49459f602b55a86cdc2a11709002d10a035b75d24cbc74bcd03c82"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.15/stella-0.8.15-x86_64-apple-darwin.tar.gz"
      sha256 "55d6ec3f0efbacbb303137561286b99c18aa24a36303f251ed62a819aba6c681"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.15/stella-0.8.15-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "09dee0c2f3c895b180b424d43ed7bb98f551fca2404b56f19aea0c22fd0b074b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.15/stella-0.8.15-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7acd03989c700078327c90fd952ae38f7cbd9852c28c55aee4bb9707c270f288"
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
