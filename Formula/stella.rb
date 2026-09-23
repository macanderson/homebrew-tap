# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.435 / @SHA_*@ placeholders below with
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
  version "0.9.435"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.435/stella-0.9.435-aarch64-apple-darwin.tar.gz"
      sha256 "f79978010c067ddb38ec3d480f6588fc929d6e9825af2b9e9816aa65a2945cd6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.435/stella-0.9.435-x86_64-apple-darwin.tar.gz"
      sha256 "cdc0b1149cefd39c0b07986f9feaa5b782fb3bbd2cafc995135c6370e8c54d45"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.435/stella-0.9.435-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f6d1b0087e6c0781e186a04918c8997cfdb41560d332075a2b3385d126ae791b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.435/stella-0.9.435-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0c685e41da5fcd048a4563f9d6f7cb8b64d928a6e3bb1c970d291ac133c2d1c2"
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
