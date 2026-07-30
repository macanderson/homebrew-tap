# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.11 / @SHA_*@ placeholders below with
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
  version "0.6.11"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.11/stella-0.6.11-aarch64-apple-darwin.tar.gz"
      sha256 "619f0f6c2a4b63dfef3244b60a0984cdd53570a487917df239c07fdb49bc9c75"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.11/stella-0.6.11-x86_64-apple-darwin.tar.gz"
      sha256 "ae3f33465581c3581ca5beb4f17e6d4a025dff84190138cf362cc690ad575420"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.11/stella-0.6.11-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "70a67b49ab2819b9d8c625f9b2d2c2bcad72b246c20a2ec2a12a45f48ede7ccc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.11/stella-0.6.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9075e1d21e1cc2e8d6f4ce905d14d1ee6c6fc6231e505703730d4a0279261204"
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
