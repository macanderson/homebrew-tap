# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.487 / @SHA_*@ placeholders below with
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
  version "0.9.487"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.487/stella-0.9.487-aarch64-apple-darwin.tar.gz"
      sha256 "98be181154266bd14277e194521c17565459596b3b83c60eeb9edde6f8e8cec4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.487/stella-0.9.487-x86_64-apple-darwin.tar.gz"
      sha256 "420e14e6d0aa60d69aa9746a020df893009fab5a3a376ea57cfc61ed8959b0a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.487/stella-0.9.487-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "05f8e85dec8e4b11f5119c3fbf1bc27c1000f3497d1c819e3176203f8a8b15ce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.487/stella-0.9.487-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fcd823a66e924a4405118db94e1fcdf3e5087106b9addd9ef0cd12070899980e"
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
