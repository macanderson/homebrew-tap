# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.410 / @SHA_*@ placeholders below with
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
  version "0.9.410"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.410/stella-0.9.410-aarch64-apple-darwin.tar.gz"
      sha256 "c96fa2f65a52ad6a2c8f4d568e33ac05777dc8119bf377ac4b5d6a01c5cc4f1d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.410/stella-0.9.410-x86_64-apple-darwin.tar.gz"
      sha256 "dccc4b93ac0ab98eb7303023dff9976b52a37ff8ec4fa0a7f18ae19dcd1b7274"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.410/stella-0.9.410-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ede9c13a0d3ca588e1c4823468434424cbe30207b4f21ec3b6bd93e9a4c0aa10"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.410/stella-0.9.410-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4ee6e2f3513951fcbb2f029e08250d677d9a2a263c8fbeb55cd2f57b739dbf5b"
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
