# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.336 / @SHA_*@ placeholders below with
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
  version "0.9.336"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.336/stella-0.9.336-aarch64-apple-darwin.tar.gz"
      sha256 "0800a561a6ad1ded613e43f0d7135c75dc5f7f6d4cc21d591d0a85dbcda3155f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.336/stella-0.9.336-x86_64-apple-darwin.tar.gz"
      sha256 "ab8606325d2a6e76068e16f610ec4ae8bbc5324e5655df12ab673ac46ac962cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.336/stella-0.9.336-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bb71d5a5005382ae51705d5a46eaf85c22501cd13abe40a09a9c16ef6adc4694"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.336/stella-0.9.336-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0bd616c11d8ebb4d776e6181ff0fb57763a0330b7a4fcfea71bb9f54af98190d"
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
