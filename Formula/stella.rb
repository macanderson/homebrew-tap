# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.189 / @SHA_*@ placeholders below with
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
  version "0.9.189"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.189/stella-0.9.189-aarch64-apple-darwin.tar.gz"
      sha256 "f7564d39482b518dee02fe00047b69fa8b8372e95a3523fcb1003cac9860d288"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.189/stella-0.9.189-x86_64-apple-darwin.tar.gz"
      sha256 "3356b1f80a58e2cf870a5c234e03c6b7b4cab31fed9526e7ef8962dd224a8aa4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.189/stella-0.9.189-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0f3efa7d18d90eef614ad7b8c170249df3d7a550ccbb03e3467277427bc0929f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.189/stella-0.9.189-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e395827ef9d8a72c1845361ed5ae3ece00af2d0466f0d2dc0e41b3f2f25331ce"
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
