# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.126 / @SHA_*@ placeholders below with
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
  version "0.9.126"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.126/stella-0.9.126-aarch64-apple-darwin.tar.gz"
      sha256 "af5daf80482df5a5d9d7c22117b5d4d06c1f1368978c4f9dcd0635b5d5c7f1ea"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.126/stella-0.9.126-x86_64-apple-darwin.tar.gz"
      sha256 "3e364ab81f4cc6117b4ce49d7a404a96c65f52e824dbd131f1b4094a03f8f6a7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.126/stella-0.9.126-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4d58b2de5a172e7dd9e364e0506d70bf5e3fd72054ae14609ae248155f7aa863"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.126/stella-0.9.126-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7a4105e9b543e6998cda3c659c69f734297e0c4b8821f4f52c8f92e5bd62f629"
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
