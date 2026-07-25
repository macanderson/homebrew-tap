# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.23 / @SHA_*@ placeholders below with
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
  version "0.5.23"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.23/stella-0.5.23-aarch64-apple-darwin.tar.gz"
      sha256 "48af1cef76706acb468efba8517449e8b06112fb2428a79a9d1179ce898ab20b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.23/stella-0.5.23-x86_64-apple-darwin.tar.gz"
      sha256 "afb2177fe3c2906804a414cce857994e1561aa327c44ce7c8b754318696c25c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.23/stella-0.5.23-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a67af9bf9834e031aa9337c268022426d33442e0f72047e813e4afe09ddfffbb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.23/stella-0.5.23-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b92fabd0dd0106e67f70be28ed1ab48c9a0e6dcb371199fc54069e4c444b6ce9"
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
