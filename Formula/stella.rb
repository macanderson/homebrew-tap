# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.407 / @SHA_*@ placeholders below with
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
  version "0.9.407"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.407/stella-0.9.407-aarch64-apple-darwin.tar.gz"
      sha256 "c842ef07b5156fdefb9ad8b7cb3c376f4586288e2f32bc4a3b61144ded9655f3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.407/stella-0.9.407-x86_64-apple-darwin.tar.gz"
      sha256 "dee668155dc6ffe34ff8191b2513ed7687c42643d384f2b0ab851e0e5880b87f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.407/stella-0.9.407-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a7eaac962f3a1aa62f8f2cfa5e364dc5e3ac82c29e3bae2b6e9bffbba150016a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.407/stella-0.9.407-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0c5ef8cd6c971467545ada6276d390e4829f183d07e3745e7d1bd9bc59633041"
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
