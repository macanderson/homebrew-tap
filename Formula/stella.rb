# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.24 / @SHA_*@ placeholders below with
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
  version "0.8.24"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.24/stella-0.8.24-aarch64-apple-darwin.tar.gz"
      sha256 "c146babe957e19d8d6b741b2be71087b92be9b9e16689587f58557ce7d442716"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.24/stella-0.8.24-x86_64-apple-darwin.tar.gz"
      sha256 "7d14c47e2c35a15c1284e652dee0eddffe6baa46fb7a48dee13fa8a32391baf8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.24/stella-0.8.24-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6352f82a7c475d8c6e7dec08cfdafcde416e28927bd9346ad9d1231f2e1a05b4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.24/stella-0.8.24-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ac151d107156eb2fd5fe6b4d42b61191e249e8b8cfa9b81ae0fe5a48e8800147"
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
