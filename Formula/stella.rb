# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.292 / @SHA_*@ placeholders below with
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
  version "0.9.292"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.292/stella-0.9.292-aarch64-apple-darwin.tar.gz"
      sha256 "382d36ae92489239cc305811bcc54cceeed0cd05fc7e7e882384204c30096c7e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.292/stella-0.9.292-x86_64-apple-darwin.tar.gz"
      sha256 "d84aaddaf70039fc514cf0b2fa7c739ebb97215b53c78752ef7c47fcf1faf5c7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.292/stella-0.9.292-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2ea7ed7898b31c629d7c47e1e7256b9b7b37498b4e67dc8455e80785a887e964"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.292/stella-0.9.292-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0989c20f39ff1b38ae1aea609e5568ad9854e7ba7470bad6e0d1f21cb81d316f"
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
