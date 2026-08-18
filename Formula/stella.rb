# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.99 / @SHA_*@ placeholders below with
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
  version "0.9.99"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.99/stella-0.9.99-aarch64-apple-darwin.tar.gz"
      sha256 "9f6e2ed2b0a94e1e40332fedd6f455efa1bb9550563fe83950af4a0d5572a542"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.99/stella-0.9.99-x86_64-apple-darwin.tar.gz"
      sha256 "ae26eb94c28a4cb8f9c5492313ca96a3a2b0c314fa35f3ed1f22d6efd4d780b4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.99/stella-0.9.99-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e6f71a89a14a6a7026d0af34c252f56ca8c3b2b9f12f405159bcfa9224a92415"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.99/stella-0.9.99-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9ad728a7508ab1223fc8e3d15c722f8b58126a8fdc18d91d0785286e231daca8"
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
