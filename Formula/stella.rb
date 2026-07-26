# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.51 / @SHA_*@ placeholders below with
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
  version "0.5.51"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.51/stella-0.5.51-aarch64-apple-darwin.tar.gz"
      sha256 "9a86cfa1951c1158cc58a4573534c82f0eef20ac31b71ad91c3917ce2d3e5145"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.51/stella-0.5.51-x86_64-apple-darwin.tar.gz"
      sha256 "3dc3b01d82a4e4be67a2ef9f1ba99a6dad384110a0c4ee065941656973bc2124"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.51/stella-0.5.51-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fadf7cca50946092a339eca8b7ccf66c7082a70f436c63944422eb87fe65a853"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.51/stella-0.5.51-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9c517f102c7219dda18efb20a4c111576c7b9507ff6b7c24cd3abe36b20db46d"
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
