# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.98 / @SHA_*@ placeholders below with
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
  version "0.9.98"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.98/stella-0.9.98-aarch64-apple-darwin.tar.gz"
      sha256 "d2c8614c2ffd5e68c182477b2475e7c0b85f653bc7d19b47ad4f56122d33dd00"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.98/stella-0.9.98-x86_64-apple-darwin.tar.gz"
      sha256 "1dadc92b32921743d26d2ac012bb32f927e1a7a2b6b118f910f4217291189c0e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.98/stella-0.9.98-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "22a13a3bbb6ddaca2bdd50dbf0dede919aef873bccf0c807afecb40c407b9f28"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.98/stella-0.9.98-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "58da31e8edcba17f4131ecccf71ec40892b037627136df7f77514f28065ee77c"
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
