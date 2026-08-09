# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.34 / @SHA_*@ placeholders below with
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
  version "0.7.34"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.34/stella-0.7.34-aarch64-apple-darwin.tar.gz"
      sha256 "70c13691778ed52fd10c1ce132b3b760b976500c963323eb569d5e85f2bb05b2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.34/stella-0.7.34-x86_64-apple-darwin.tar.gz"
      sha256 "a81fa6fe79c3e8545349db843a63b3d3ba70bc2bba843e8d4a603210e38d5365"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.34/stella-0.7.34-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "79b8b6fd10e6b7e085f48b411948048c795a8447731d0f50f524575e8f112366"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.34/stella-0.7.34-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5273c5557a74423997ab9a4fa3ece29de0cd491ce7f4b0c454edcfbe8fd8bc46"
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
