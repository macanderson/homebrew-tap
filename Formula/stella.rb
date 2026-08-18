# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.91 / @SHA_*@ placeholders below with
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
  version "0.9.91"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.91/stella-0.9.91-aarch64-apple-darwin.tar.gz"
      sha256 "1ab7d1aec430da8a4a12701c1472e245d71523e240fa7465b60093a91c0ac786"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.91/stella-0.9.91-x86_64-apple-darwin.tar.gz"
      sha256 "11fe66a5fbd67a8d806d57997f0e7545a1ff3a275ee6c44b7d25f5926eb68eb9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.91/stella-0.9.91-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "31f019eb7a718c57f2371b4d559edd9d8955c72f3138309f3315591b3e43f8c2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.91/stella-0.9.91-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "da33d86427969d664fd3aa3df3be45e9f65e7fe70ca4f5a390a83bfcb122e5b1"
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
