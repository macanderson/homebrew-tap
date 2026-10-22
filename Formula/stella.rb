# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.499 / @SHA_*@ placeholders below with
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
  version "0.9.499"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.499/stella-0.9.499-aarch64-apple-darwin.tar.gz"
      sha256 "c172b2e365cae2c4b684705c6c2377c0d1141ea3e3459ec368e3d1356651e047"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.499/stella-0.9.499-x86_64-apple-darwin.tar.gz"
      sha256 "4c06be0ea2879dfd1d21e49aefa28e7c8fef1fdb6b98d23c5539fc80e90fdab4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.499/stella-0.9.499-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2c8b1ed7a46521d2c42fa0da5a39e8ab2ab747fefe49db375dab26d735ab2203"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.499/stella-0.9.499-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "74bc4d91f4a326e38392b6179e65d7d05b5ea9a688d9f413ad9d658ba4d5d6be"
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
