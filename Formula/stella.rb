# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.148 / @SHA_*@ placeholders below with
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
  version "0.9.148"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.148/stella-0.9.148-aarch64-apple-darwin.tar.gz"
      sha256 "2c2ee6a2cda6cf866b45a6863ddab8ba9dcff9ec5eeadf0d46b860323d614df5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.148/stella-0.9.148-x86_64-apple-darwin.tar.gz"
      sha256 "df4b5537c7f736a4beb7c2ca42f3f474cc1a5ea82e620b3f66f677986b17ac4f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.148/stella-0.9.148-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "abd275d873f2388ec53e9f705ee934ee99bcafeeed5b80330b22506843d7ee8a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.148/stella-0.9.148-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a80e4e4c141cd4d91eb2d925042f6b3c98e65b0ed6253d45d9486805d36fd115"
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
