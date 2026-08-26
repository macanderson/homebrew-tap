# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.224 / @SHA_*@ placeholders below with
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
  version "0.9.224"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.224/stella-0.9.224-aarch64-apple-darwin.tar.gz"
      sha256 "a19d10341298efdb267a641da015651faec616f1a0e9b6dedbca30aa5e57d176"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.224/stella-0.9.224-x86_64-apple-darwin.tar.gz"
      sha256 "3473458ec15753e445c576eee67afac8ad0b652aa39e6e564361509a5472ec82"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.224/stella-0.9.224-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e35ed7efa0d11ceacb34de5b25523899d418d7c4dbf2484e7da6adad857ec328"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.224/stella-0.9.224-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9287851f84ba89b0d3f697c37d35253df0737948467e6cf4f6fcc5863df81573"
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
