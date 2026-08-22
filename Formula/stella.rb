# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.134 / @SHA_*@ placeholders below with
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
  version "0.9.134"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.134/stella-0.9.134-aarch64-apple-darwin.tar.gz"
      sha256 "7ac233831e889a33dbd125552fd6b630e4add87bbabeba88624f2f12a7ce60e5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.134/stella-0.9.134-x86_64-apple-darwin.tar.gz"
      sha256 "bf2b984bd9a22dc810ba7a19a7759ab91636696f5bb3bfb7dc2b1249d10aa918"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.134/stella-0.9.134-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1dd3489d579c3e73df23f3e7a14fe853aa7684f0f6e8c22f521acf1cb7731018"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.134/stella-0.9.134-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d1762a160c2669e749e8179745602f99b9eda4f03a4b714182affd9911896063"
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
