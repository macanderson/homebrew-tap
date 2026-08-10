# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.30 / @SHA_*@ placeholders below with
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
  version "0.8.30"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.30/stella-0.8.30-aarch64-apple-darwin.tar.gz"
      sha256 "4af7114b17e28e0e61746ae878d98ec49626739faff42dd2d859659002ee1385"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.30/stella-0.8.30-x86_64-apple-darwin.tar.gz"
      sha256 "162335b2020c031df644f062a981e632ace2cc548b3a4cb8bec56631fac6bc87"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.30/stella-0.8.30-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fa32627f3baa6fdc459a41e45ee29b0126b5fad654c612a72b1e226b0747916b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.30/stella-0.8.30-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "59cac8d2f1e5e6e3cdd7e00c684cbeca4f0ccb8859305dc4a07bd36a2addff39"
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
