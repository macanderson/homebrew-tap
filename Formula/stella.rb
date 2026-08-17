# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.62 / @SHA_*@ placeholders below with
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
  version "0.9.62"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.62/stella-0.9.62-aarch64-apple-darwin.tar.gz"
      sha256 "0b350ffeb9c9a491ab32649013371eeeb2d725161e75a8b10f8fe745e73d0a77"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.62/stella-0.9.62-x86_64-apple-darwin.tar.gz"
      sha256 "9176f3adf571953fb8205ce1db929b1927579a4c9c1b1c4696a8aedb87fea791"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.62/stella-0.9.62-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2dad13744eb445e6d93d3e4a69069cfe375d1d54c89f47f119c12f86a91cddbb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.62/stella-0.9.62-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f2726480d24bd3ed9182792e5e920a4670a5fafb0e531cf313d5eeedc49d32d4"
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
