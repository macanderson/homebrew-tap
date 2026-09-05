# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.348 / @SHA_*@ placeholders below with
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
  version "0.9.348"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.348/stella-0.9.348-aarch64-apple-darwin.tar.gz"
      sha256 "46c366d049b7ab84bc22dbc74b1c1dcb6a4bed35a7d553ea72fe378f05f88c0b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.348/stella-0.9.348-x86_64-apple-darwin.tar.gz"
      sha256 "b19f4850d897274f19268ea0b50cfc00ab08540dee6f9a5902f09bd975c17132"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.348/stella-0.9.348-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "926fad38fa62ad65b702b4b00f4f3450355f6fce65cfd6ef955c93f33902a491"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.348/stella-0.9.348-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5def0d3a79b9e1a19aa797a8d29808ad43e5e87d4e8c788b3e29735a3c149fed"
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
