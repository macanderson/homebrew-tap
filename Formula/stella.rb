# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.326 / @SHA_*@ placeholders below with
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
  version "0.9.326"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.326/stella-0.9.326-aarch64-apple-darwin.tar.gz"
      sha256 "2c0cffa9a995d835a7a7c2c6954385f09943ee336b7abf10c042edfa77245c04"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.326/stella-0.9.326-x86_64-apple-darwin.tar.gz"
      sha256 "28b3715a280f19003d9f718ed21e308f2e8a00e7f11e12db9ccad2c093ca7d36"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.326/stella-0.9.326-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6074dbf874d4c0acc6b6a04edde328e5cb73e43b60d85c66518e0d9694a5c839"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.326/stella-0.9.326-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "579791867e462d84ca659390fc9205f8f26794df67f3a6f6b3fb219ad7ac0169"
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
