# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.323 / @SHA_*@ placeholders below with
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
  version "0.9.323"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.323/stella-0.9.323-aarch64-apple-darwin.tar.gz"
      sha256 "a12db9f45d02d5376b934d273d64d8cfd58e6b787eabacf0b23ac2eb063a2991"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.323/stella-0.9.323-x86_64-apple-darwin.tar.gz"
      sha256 "28abedd45a943e8ea8210243213a5378794f6a3be9d61ac6cb936b0297f32667"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.323/stella-0.9.323-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "73ced4cf9f633f860990be31c8c19a1a732cbf59c58bbe44294909952deaff02"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.323/stella-0.9.323-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c9f341af41ed70cfb2b551062ca69339f8b2cc358f4e6e08fdb6a6550042615f"
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
