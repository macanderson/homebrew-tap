# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.453 / @SHA_*@ placeholders below with
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
  version "0.9.453"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.453/stella-0.9.453-aarch64-apple-darwin.tar.gz"
      sha256 "54761babb97ceb6b97b195179d006c6f2284e7e764cac78e7ff69ff1a6ef1e7d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.453/stella-0.9.453-x86_64-apple-darwin.tar.gz"
      sha256 "17006f8ff4e679b98017f3c007f1659b1247449f14790af7b8cd56d4f2d359bb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.453/stella-0.9.453-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "702fa082e4f4667ec28c068b591382f2730f5f888744087232386ea370fb30fe"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.453/stella-0.9.453-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "47557a4819c057163c60a6a0f349aaab7129da2fbb33c2357f52759d256f4c4b"
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
