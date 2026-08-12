# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.8 / @SHA_*@ placeholders below with
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
  version "0.9.8"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.8/stella-0.9.8-aarch64-apple-darwin.tar.gz"
      sha256 "dfae86246cf95a98b58126a006bbaad40a0b8a11ca9778ca9cf201c3cc31057a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.8/stella-0.9.8-x86_64-apple-darwin.tar.gz"
      sha256 "e6bdb6e423a21716173d5b0ba16ed3d1115bfc4dc6c9cd1c0644c75b1c7e94c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.8/stella-0.9.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "161aed603b6c4f24284feca2274ede12bbf6eafd5d55b44992a979e0db16cef4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.8/stella-0.9.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f3b57d6119c037a81cbe29aed852693a833acfff2c5ea8903e80c5a9e561d347"
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
