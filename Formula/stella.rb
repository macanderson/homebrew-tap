# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.12 / @SHA_*@ placeholders below with
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
  version "0.9.12"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.12/stella-0.9.12-aarch64-apple-darwin.tar.gz"
      sha256 "1e0fdc2be7032a808dd34381f8089f7736d3a9e6385bc6198b48d573f6e9ac15"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.12/stella-0.9.12-x86_64-apple-darwin.tar.gz"
      sha256 "ff94edbd9c7bc52491e57dfa79b0f396dfbec32bda1e96f67e7c6b65e55afdbc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.12/stella-0.9.12-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "34470244e12694c5f61a6208c1d92c2b5754f3a21344c79471e968cd50644188"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.12/stella-0.9.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c81f745942a86576faff2c702de85498e5bff845a2b24e3050afc8757a80ee85"
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
