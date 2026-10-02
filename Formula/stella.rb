# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.470 / @SHA_*@ placeholders below with
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
  version "0.9.470"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.470/stella-0.9.470-aarch64-apple-darwin.tar.gz"
      sha256 "d64b0db138267d5165af76a9e2f2dda1834878a482c7ef69a8981a9256e20862"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.470/stella-0.9.470-x86_64-apple-darwin.tar.gz"
      sha256 "042ea39199742da39463858b6520ec3ed0ffdfd1f58b33b84d29fb55c3247347"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.470/stella-0.9.470-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "df7ed1a909da73462f1ef128bbcdb21b7aec5dc6643c93e2315fefbdb33f6198"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.470/stella-0.9.470-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "58bf041563bb5a363120a4b9722f2f84996ff046219d784d267f79ee251c2ede"
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
