# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.44 / @SHA_*@ placeholders below with
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
  version "0.6.44"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.44/stella-0.6.44-aarch64-apple-darwin.tar.gz"
      sha256 "963ea3d334ee41c630b15b56c0104c6b02080a262d79a6206c1ab1110d38694a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.44/stella-0.6.44-x86_64-apple-darwin.tar.gz"
      sha256 "7720c213bcc3791112ec718c9b6f9ee7ca5af4712d683609883d731b3a8e35b3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.44/stella-0.6.44-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "482482e20f9e55ea9db3434e165a31b21ff451cc5ecda69c8918f30db02e6ea4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.44/stella-0.6.44-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "725bb840718e7111b0ac2cf8be4a5ae766019ea0c31fdbcdec6c37bcf687e5f8"
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
