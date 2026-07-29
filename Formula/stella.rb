# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.76 / @SHA_*@ placeholders below with
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
  version "0.5.76"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.76/stella-0.5.76-aarch64-apple-darwin.tar.gz"
      sha256 "f664a9497dada4bfc05a0abdeec4883a6bfec7f9d392f7aac0a1cb723b8bbfcb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.76/stella-0.5.76-x86_64-apple-darwin.tar.gz"
      sha256 "859b84ca2926685e070ecea03c0ab77083d144e1a1b3ecd65a6e20a8a792dd83"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.76/stella-0.5.76-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3393ff1a84d3c8d7c2526379742a3f0ca44d9b30525cb6be5bffadf1c116ce56"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.76/stella-0.5.76-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cf853e4666da9b49d39e194b113a77cb51fae74d390f33137d7dcee871e08d5b"
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
