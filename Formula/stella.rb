# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.417 / @SHA_*@ placeholders below with
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
  version "0.9.417"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.417/stella-0.9.417-aarch64-apple-darwin.tar.gz"
      sha256 "35727fb6de8f2a16dd66dcd9d4ac7a29686b08aa08355c4b63c81dfd7bc9afe3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.417/stella-0.9.417-x86_64-apple-darwin.tar.gz"
      sha256 "f930a89b8289326902f7100eecbbc87e8d4ce29e704ca3030acb282596e6b794"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.417/stella-0.9.417-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "088cf25a90602a9db5cfd1c226995c2ef19a0f6458b012959b1f757b6d211081"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.417/stella-0.9.417-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "50412ae47f2c910e70b2198ffb59042f759e7ab7e0937cbbd1101d67e47770b3"
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
