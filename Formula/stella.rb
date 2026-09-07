# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.382 / @SHA_*@ placeholders below with
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
  version "0.9.382"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.382/stella-0.9.382-aarch64-apple-darwin.tar.gz"
      sha256 "b0a729ea54a3dd41842acb2c4c98216f16ad6b0868e84c8c32eaa36c6a4684e1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.382/stella-0.9.382-x86_64-apple-darwin.tar.gz"
      sha256 "2b1f6c3a66638031b4bff841cc09ecad1628e2447c9b514a1120aa9fb0bb8614"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.382/stella-0.9.382-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "84274bf60a2891b751cd1596a04beda871deba99651479325f36c95aea8066f2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.382/stella-0.9.382-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a4278953031ed995e0867efc2839054087ade86ff4656175679abe9bc968979e"
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
