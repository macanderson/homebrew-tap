# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.117 / @SHA_*@ placeholders below with
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
  version "0.6.117"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.117/stella-0.6.117-aarch64-apple-darwin.tar.gz"
      sha256 "dd2ce71532d4b7dc7d90fd7d4b47d6b67ddfe9c21fad176672220590a8873f22"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.117/stella-0.6.117-x86_64-apple-darwin.tar.gz"
      sha256 "138db08227059d778ba75e8f71194d7123675b02874aa6f0bc2c5aacd0511c68"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.117/stella-0.6.117-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "824c43bb73033f339fcf5489207d822d1cc6f04f61bb326229eb1a3c8c9f6373"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.117/stella-0.6.117-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a83f955a5fc5a535521436cacfe4694034c398a7b83a076f4570c0a0a434b902"
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
