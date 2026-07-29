# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.0 / @SHA_*@ placeholders below with
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
  version "0.6.0"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.0/stella-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "97a7c5a7555553983b17cdd5d1c788435a636f78834d7003c6bc9d28dee69e5f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.0/stella-0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "709aad44cd431f6bd7de06745443744db35a9e8131323603743dc52124ae4119"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.0/stella-0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "affe795b13d9b50a634f1aac12df2e8e9384796230739d30a1bb0201613ea7e2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.0/stella-0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6d692a715be345e88b62f221ae3057c63aaffecabc28f14bb8fe04f66a2e3100"
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
