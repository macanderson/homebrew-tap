# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.1 / @SHA_*@ placeholders below with
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
  version "0.8.1"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.1/stella-0.8.1-aarch64-apple-darwin.tar.gz"
      sha256 "b7f10887674719afbbe4db46f7c9b5582e7cc2854e8bb58478092c5ff0eeea89"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.1/stella-0.8.1-x86_64-apple-darwin.tar.gz"
      sha256 "038c6dc8a0be906f9f1dec7f17244d17a61696f8a982ccad4e5096ba2e4bded5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.1/stella-0.8.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7b2f924b43aa3687e662ce45381933ee11af34dc0d367dbe8d5f34f143d7e31b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.1/stella-0.8.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "af7a2e629d4751a2afa967fd83921035684f3136b06cc0bae5e7a99728b83684"
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
