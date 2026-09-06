# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.354 / @SHA_*@ placeholders below with
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
  version "0.9.354"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.354/stella-0.9.354-aarch64-apple-darwin.tar.gz"
      sha256 "023fe9d1ba3c4b61cc6ed7827911fb817ff16e411a3bc1686cfc8a06a2e6c659"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.354/stella-0.9.354-x86_64-apple-darwin.tar.gz"
      sha256 "3fda6065dba2d2414284c6707c6e081e21bcd3dcbbc28026657e9e2030bcdc85"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.354/stella-0.9.354-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b59a246b7624a2c300f2c82b8db7a10193a526b991adc8346dfd4b89410618a5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.354/stella-0.9.354-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b1efce77bbb416eaff49aafe0988c5382a787fee1e917e761a54993638da0927"
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
