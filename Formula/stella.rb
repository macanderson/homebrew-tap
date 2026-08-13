# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.36 / @SHA_*@ placeholders below with
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
  version "0.9.36"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.36/stella-0.9.36-aarch64-apple-darwin.tar.gz"
      sha256 "c7655b1b1f3fa1e0f1b642b636044e53f46577aef25068bc1a74350d80dc56c8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.36/stella-0.9.36-x86_64-apple-darwin.tar.gz"
      sha256 "7fe5f8984ca8d834079c04fb86056e85f4f59354c436ac2af52f7ffc0c9d0777"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.36/stella-0.9.36-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f5f22a55591302e8cffd3402f430bc17aa2e5c6d90aa0670f1ee482ca336d484"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.36/stella-0.9.36-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7698952cde355b5d5285ce8f9f8fb0f7f37967a3826ab9d12d5dfbc1dac5bdbf"
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
