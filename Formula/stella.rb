# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.30 / @SHA_*@ placeholders below with
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
  version "0.7.30"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.30/stella-0.7.30-aarch64-apple-darwin.tar.gz"
      sha256 "40af96010d0ccf32ad1d83a77ab5f7d674d284279fc629f2e949b65613ee4053"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.30/stella-0.7.30-x86_64-apple-darwin.tar.gz"
      sha256 "473ec287b83f4f639f89bf83f0fedd040bb10124b4a2bc94033278460a251384"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.30/stella-0.7.30-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ed639b1f11ef03a37c93e45216b046f62c0bc85d69101fd974ab1498e6e681e8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.30/stella-0.7.30-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7f521e1a7bb3aa4c6f2cf370c3f697843270d6f94e8f7b5867e482b7d0ddc20a"
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
