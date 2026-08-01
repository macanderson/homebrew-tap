# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.63 / @SHA_*@ placeholders below with
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
  version "0.6.63"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.63/stella-0.6.63-aarch64-apple-darwin.tar.gz"
      sha256 "d49d8b5fbadcb50ec5121d99f55570e45b56e2755a99e861faf84661073cdda9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.63/stella-0.6.63-x86_64-apple-darwin.tar.gz"
      sha256 "a603b8566ba4b6686707fe0a3eb70e6adad77868cfb72c966a2284db9d503203"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.63/stella-0.6.63-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "18f77b5bafb7b2b3d41741feea669f4951e3303e8c77f2374bc76484dcca8c6e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.63/stella-0.6.63-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "042ae57666fb61c02e04cbc832a8adb8875a3732fb78d1242f8769a1e76a0aa0"
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
