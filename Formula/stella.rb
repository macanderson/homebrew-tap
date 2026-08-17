# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.82 / @SHA_*@ placeholders below with
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
  version "0.9.82"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.82/stella-0.9.82-aarch64-apple-darwin.tar.gz"
      sha256 "e7bc0a4104a487e0b08201e89b7a7aea1b3bd31e8a692627c32e7b8faba0177f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.82/stella-0.9.82-x86_64-apple-darwin.tar.gz"
      sha256 "8328e8c5186e2f12e58c17d18ce4c58ad0353156d5f2d05cede1617196f04dd9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.82/stella-0.9.82-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "92ae36b9334310f773967340a89d98ba794bb38579360add38f4a83e9e6a2bb5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.82/stella-0.9.82-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "023b0fc9e7dddd332a24ac1a6d4fc059a8738ccffb710a2e66ea6a2175759b72"
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
