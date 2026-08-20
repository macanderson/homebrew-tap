# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.114 / @SHA_*@ placeholders below with
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
  version "0.9.114"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.114/stella-0.9.114-aarch64-apple-darwin.tar.gz"
      sha256 "dd81f963bc6dce396b2f5e2d33310003ca2d434b7889e62ddf4ef67965b1f430"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.114/stella-0.9.114-x86_64-apple-darwin.tar.gz"
      sha256 "fe2d421e488efb8fa60d3ac65eaa480dc39ac0900c6088a738ed748df726f7ed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.114/stella-0.9.114-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "23d019ebfab7218600cc81145523e69bbe781b14cbbe9c1e9e713dc9dda8b730"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.114/stella-0.9.114-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8cf3d337ebd98efdedf8ebf90b5511591d9b0a02b8b5a92843e06862f4154a6f"
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
