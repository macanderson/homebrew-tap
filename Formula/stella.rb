# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.51 / @SHA_*@ placeholders below with
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
  version "0.9.51"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.51/stella-0.9.51-aarch64-apple-darwin.tar.gz"
      sha256 "b7666467b03bbbbb3d34296eaf1ccc719174e3750e61c024e30db949a51413de"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.51/stella-0.9.51-x86_64-apple-darwin.tar.gz"
      sha256 "47d7ac180c1a691339bc2c44c29eb0d8e69d4e553fa77c89e35f77518cedc18d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.51/stella-0.9.51-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ac2f3fde81b6d8094882f06663d7454ccb0c5adb0c3a75c266e2ac9f2bf82bcc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.51/stella-0.9.51-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3105d1a0c0d20d0c15064e395b91e2c6361dbda44dd51cd56f557145d455eba8"
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
