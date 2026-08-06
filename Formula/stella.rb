# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.120 / @SHA_*@ placeholders below with
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
  version "0.6.120"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.120/stella-0.6.120-aarch64-apple-darwin.tar.gz"
      sha256 "f19726a0beb529a8d7ea0f7d9430a7a81d89b9bed2729b0cb5d301f2c1e5fd9c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.120/stella-0.6.120-x86_64-apple-darwin.tar.gz"
      sha256 "b95adbf092f784236e939e721d11652a5c80c0509c9c520e7ec6bb66dde385dc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.120/stella-0.6.120-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b9d0a4749b0db3dcff57ebbd3654c3b5024fdc9b77fed447e076d9764cf907c6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.120/stella-0.6.120-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "322e77eccc358421602474ffce6184e2f64aa55076f850bb95b588bcee5daafe"
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
