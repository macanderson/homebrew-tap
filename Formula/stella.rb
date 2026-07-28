# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.65 / @SHA_*@ placeholders below with
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
  version "0.5.65"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.65/stella-0.5.65-aarch64-apple-darwin.tar.gz"
      sha256 "184dc75f36df50ae3a20bb3895f2f93aa0a88f6d5bb243d01298b28894e6d4b1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.65/stella-0.5.65-x86_64-apple-darwin.tar.gz"
      sha256 "4f100363d147bdd5edd463e778e8b9f611104fe71154991542b5c8c727419ace"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.65/stella-0.5.65-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3ecfaefa29c714bbf0bf27630e13c4476f51ee8ad97bd9bead213cd730cd4d53"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.65/stella-0.5.65-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c0f04c161b2246dcb58e6d075450c4697aba67a86125d100523d6a87f9f8abf3"
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
