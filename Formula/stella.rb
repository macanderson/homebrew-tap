# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.155 / @SHA_*@ placeholders below with
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
  version "0.9.155"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.155/stella-0.9.155-aarch64-apple-darwin.tar.gz"
      sha256 "fbcda1f2a6231d549494842e961a4f11f3aae2b4a0b99642ac511e8f9630e5bd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.155/stella-0.9.155-x86_64-apple-darwin.tar.gz"
      sha256 "a7807e3a197d904ca52cbbbedc149ee55550c25d8681a1f8981b1baa19736182"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.155/stella-0.9.155-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cdb1f95ae75f6ce462adf9d1ae1b3c4c01274e0cd569df2161f16d7313d37ddd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.155/stella-0.9.155-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "48eb969f3fa29e5646df3d9c57c0fc124931f6447d6df195d1efe10c8434aa74"
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
