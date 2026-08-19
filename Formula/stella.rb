# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.103 / @SHA_*@ placeholders below with
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
  version "0.9.103"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.103/stella-0.9.103-aarch64-apple-darwin.tar.gz"
      sha256 "e711d69b0df5be5a6607826bcb8d1a44f62588ca5083aa5f7e59ccd2dacb0bb7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.103/stella-0.9.103-x86_64-apple-darwin.tar.gz"
      sha256 "cbc25db7850e7b2c9cb754041ce9c693cc9b5a824058d0b10d6629f557350578"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.103/stella-0.9.103-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b71c852e4581c25c793832ac3732f9eabf5ff169a84ed528bc17294de0603270"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.103/stella-0.9.103-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1233295807d6c16881ad0e4072dec8a2f86f462d8e0e511ba4f68abe77049bde"
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
