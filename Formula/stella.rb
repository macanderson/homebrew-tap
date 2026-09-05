# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.330 / @SHA_*@ placeholders below with
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
  version "0.9.330"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.330/stella-0.9.330-aarch64-apple-darwin.tar.gz"
      sha256 "3260381d3a2b669515375c144847f9ff3bbeb977d0e5e756b936224a18a53791"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.330/stella-0.9.330-x86_64-apple-darwin.tar.gz"
      sha256 "b1da193187601cae5b7849cd0e2275013c77c1766ad8c3a278aa11d5f13605c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.330/stella-0.9.330-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "875f0da60b6fa97e3786df4b62db25595fba5994fb185accfbf79aa0fa885cae"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.330/stella-0.9.330-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bafd38b5a7df256e78f34a09a8515d32d2599cbd87631d0816000a00fadd599e"
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
