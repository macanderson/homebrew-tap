# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.312 / @SHA_*@ placeholders below with
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
  version "0.9.312"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.312/stella-0.9.312-aarch64-apple-darwin.tar.gz"
      sha256 "cc9307c64f17372f235727b6b483d6a14f3f5bd8e30d0aaaa197dc4a92d389a7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.312/stella-0.9.312-x86_64-apple-darwin.tar.gz"
      sha256 "07a995cd5c23876e91ca0d92eb4ac310a6a1129e79bd0515c882ee7b57431ff4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.312/stella-0.9.312-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2950399e86471eece55da8e0e7c3f1974c9b75caa504a2c8fd1b62664d6a4e17"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.312/stella-0.9.312-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0971e516f439219d5eb3a189554972dc1612b38cef9d5be27140f6c26d4ff99f"
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
