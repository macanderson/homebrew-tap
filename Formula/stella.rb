# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.197 / @SHA_*@ placeholders below with
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
  version "0.9.197"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.197/stella-0.9.197-aarch64-apple-darwin.tar.gz"
      sha256 "7d4f032d593e793dc9593067051e8ec3df00ba8a02545831490d031deb864e51"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.197/stella-0.9.197-x86_64-apple-darwin.tar.gz"
      sha256 "2bdacc1c93bf14a29ad3d2d96ca29dd1c1863ae7dcf076b55b953eb25ab24737"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.197/stella-0.9.197-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4a3c09e5ff330259cac9d9d785cca2f7fab23ce088a1e9d71d1d4a7b38918ce1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.197/stella-0.9.197-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c1f93454d34d0f1c45c2c06a8efed0de9f657039775eeec28eb87bdaffea3dd6"
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
