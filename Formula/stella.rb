# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.443 / @SHA_*@ placeholders below with
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
  version "0.9.443"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.443/stella-0.9.443-aarch64-apple-darwin.tar.gz"
      sha256 "cb658d4f698f41dac301f6f8b9da4fda47895de74579fa8a72ac878762f5eb04"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.443/stella-0.9.443-x86_64-apple-darwin.tar.gz"
      sha256 "6b33d20e0f4ff8474ecb101f3bd64a056125c91c89de2be562e0be2cd84b10d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.443/stella-0.9.443-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5927813c9ca762daa4cedd863345beed035a8b396a2abba812a6525d16e7a0ea"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.443/stella-0.9.443-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e821f52224c9d4d3e7bbcf5e7fb1dc63f3f0702426ac2adba82d0fb465cddfe5"
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
