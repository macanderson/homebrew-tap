# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.33 / @SHA_*@ placeholders below with
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
  version "0.7.33"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.33/stella-0.7.33-aarch64-apple-darwin.tar.gz"
      sha256 "eb18d0aac2ef1b8a3acce8849b58a2bf091666c77e12b0f8529f728468a116b6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.33/stella-0.7.33-x86_64-apple-darwin.tar.gz"
      sha256 "65eeb36c0ce0da4bfa8a85c6cb42e097682ec8e0219909f4cd954b09f6ac746a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.33/stella-0.7.33-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d6d4297c5486cca9780ea6689387b823f9fe70d8fc854ce0ad1759ff7ae6e4ed"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.33/stella-0.7.33-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4372146cd07612fac23e1a4abe6521c4725032ed09cb89c954a3a620e6f38f07"
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
