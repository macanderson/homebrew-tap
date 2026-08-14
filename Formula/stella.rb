# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.43 / @SHA_*@ placeholders below with
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
  version "0.9.43"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.43/stella-0.9.43-aarch64-apple-darwin.tar.gz"
      sha256 "c91592a03a279ec6873d4104c8069e125e28336d3ad4dacd1ca44521e2b79ee3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.43/stella-0.9.43-x86_64-apple-darwin.tar.gz"
      sha256 "9bfb65966b5561a469f321f50c688c11c88af24f71d0d9bbd203c2e0182f9f63"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.43/stella-0.9.43-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "932180a6f4b003afa84a70bafd3462d1b4459cef537424ba2593c9462e61fec4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.43/stella-0.9.43-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e9e72df829b739cb3cb3c646f89669e10ffd8cb5d87d60adc49d4e8c1a7fb6e6"
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
