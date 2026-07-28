# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.66 / @SHA_*@ placeholders below with
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
  version "0.5.66"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.66/stella-0.5.66-aarch64-apple-darwin.tar.gz"
      sha256 "1f85d73e1a6fb7ddf17f7f7292ddf474b5ed1b06d2cebef791a1a05f0d68db55"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.66/stella-0.5.66-x86_64-apple-darwin.tar.gz"
      sha256 "0543a4bfc5d92a7eec7bcd2a6a005841a5d62c48615a5cf625c2f9792814da29"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.66/stella-0.5.66-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a1d0252010ba34ea8def14ea6009040d50bb59242fd071f1672ab9f811186f96"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.66/stella-0.5.66-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f9ce205032bd059a2231d33f884670e5dbdee6ea8e763e5c0348d7e0c0b0315f"
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
