# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.131 / @SHA_*@ placeholders below with
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
  version "0.6.131"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.131/stella-0.6.131-aarch64-apple-darwin.tar.gz"
      sha256 "31f52e8d9f42a42761ff72c72778118cbd2aeee8de4f56ee17bcd03599264764"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.131/stella-0.6.131-x86_64-apple-darwin.tar.gz"
      sha256 "dce6b8fa9faa211d977ae535ea9b63a0508fef1dbf7f535de4cec1edc389d2d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.131/stella-0.6.131-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2c76613509c4fcc4d70277c740d2bb334fc401260decc3ae05a0a42bcb9abe64"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.131/stella-0.6.131-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "468508882680d11bdb5c0a1a52ef210f7f79b13ca5e3aa8be90e7c6a2bb5e6ee"
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
