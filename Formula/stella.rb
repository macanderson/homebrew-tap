# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.325 / @SHA_*@ placeholders below with
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
  version "0.9.325"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.325/stella-0.9.325-aarch64-apple-darwin.tar.gz"
      sha256 "6f3f8d7a8beb5079dffcefca0322f8dc74c7e8afbc31035466908c77964b000f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.325/stella-0.9.325-x86_64-apple-darwin.tar.gz"
      sha256 "3e5bc65e220aa2aaeb41bbdb02a179af26206abd60864b1cb60a05c907cdb584"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.325/stella-0.9.325-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "665c0f323da45930a6635208941ec11dd87cfbe2595f1f076c29c4374e47d244"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.325/stella-0.9.325-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fd5a903d61bb3cc6a30ca53feee984dc963ebf2c48a2d4dd960de2410eafb66b"
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
