# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.131 / @SHA_*@ placeholders below with
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
  version "0.9.131"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.131/stella-0.9.131-aarch64-apple-darwin.tar.gz"
      sha256 "e9c26477fb5ce23d4674d619ea5e71fe24228130e1ab808c123d7ce3225c8bf9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.131/stella-0.9.131-x86_64-apple-darwin.tar.gz"
      sha256 "b68443fd8d6c63657f0875614abe4c9691257a0be05fb22e1fade1bd8316c864"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.131/stella-0.9.131-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c815b90324873cea4c3e49c4e7a4d331018348c0b4529bc02e6d343a2f6c4747"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.131/stella-0.9.131-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7cac31456f8eef177e6a64921291f5ef8c6b85e92bd7a0ce1d32437650318b08"
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
