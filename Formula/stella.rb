# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.383 / @SHA_*@ placeholders below with
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
  version "0.9.383"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.383/stella-0.9.383-aarch64-apple-darwin.tar.gz"
      sha256 "5b21b2c5afddfcd22e7442617927fe9b7ec90d48cf6d86a17d2f3aede431fd84"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.383/stella-0.9.383-x86_64-apple-darwin.tar.gz"
      sha256 "4971fbf726adcaafbc60334e23ac102ad9cd8096135349c6aa486455092cfea4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.383/stella-0.9.383-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1d5eeb82c85c227d2384646c4069779b46231fc42d69e62cb856d9a03180f843"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.383/stella-0.9.383-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "55debf5522c80545a8d1cddf661bc9fcd6145d4b9fe801fd6b42065f30d6706e"
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
