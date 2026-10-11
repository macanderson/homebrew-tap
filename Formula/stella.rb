# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.494 / @SHA_*@ placeholders below with
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
  version "0.9.494"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.494/stella-0.9.494-aarch64-apple-darwin.tar.gz"
      sha256 "41b82a6e6f5fe20dbe1d2ae4e330b11488792243660bc6490769f9e69582d080"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.494/stella-0.9.494-x86_64-apple-darwin.tar.gz"
      sha256 "218351564cf6745d19d4e608781369f7e4332d9eb52a3414d2ffdd906940f151"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.494/stella-0.9.494-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "07389270a6ba5466800f64a6da7846ae1ecd5e8f2de0aa9e0eedc2ce8e3e4299"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.494/stella-0.9.494-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7f30a57852f31281f51f587bcf376739bfa373d85d31d1d47569c0f3d97ecaa3"
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
