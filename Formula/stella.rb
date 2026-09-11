# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.420 / @SHA_*@ placeholders below with
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
  version "0.9.420"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.420/stella-0.9.420-aarch64-apple-darwin.tar.gz"
      sha256 "422d9e38c5e669b9c13fd4048f2f3a3620abf956c3d0f6a1262a8dd830a18c8e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.420/stella-0.9.420-x86_64-apple-darwin.tar.gz"
      sha256 "2d1eb298a5447d5d7408dae0519f2aaad0f038dc94f449a51c40c58faf4b98cc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.420/stella-0.9.420-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "201d3c60f75edc2075aed4bebd803882391da28299450b6dabe7d802a87fc79e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.420/stella-0.9.420-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c58a228c1207c2cd2f1eb7cca486af2056fd8a47599f98ff9f3e087802f522df"
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
