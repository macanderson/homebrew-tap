# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.25 / @SHA_*@ placeholders below with
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
  version "0.6.25"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.25/stella-0.6.25-aarch64-apple-darwin.tar.gz"
      sha256 "da32a111ecd00e3d3eddfdd90e3142b4dd8c58cfca570a42749f786440b35f66"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.25/stella-0.6.25-x86_64-apple-darwin.tar.gz"
      sha256 "0cb74342b5c2a0cd0d8a3af4b122c4b82e4b4c00637d392b4f125b83c7fc24e2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.25/stella-0.6.25-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7d2d768113554415e5bf36feff266d462048e604616aec3112d6a37c30ba70d0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.25/stella-0.6.25-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eb2f9496fe2f805ed087d6081be0e89502c57adcfcd446fcaf4605ec9958877b"
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
