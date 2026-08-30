# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.284 / @SHA_*@ placeholders below with
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
  version "0.9.284"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.284/stella-0.9.284-aarch64-apple-darwin.tar.gz"
      sha256 "fad02fa44e708bffb8f7901a87e2291782f385f10fcbf91bed101b375ef0d5da"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.284/stella-0.9.284-x86_64-apple-darwin.tar.gz"
      sha256 "f1a8fd166e6dd13f506e75a3ddc6d93182e87a73a2ebf3166fa212fdbe76144f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.284/stella-0.9.284-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6ea6198969b86a72a34507ce31ff15aadd2303a70eb1a8d11fa88e3d106e9886"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.284/stella-0.9.284-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fdf6a7d354751368379627c041857bf24d71f94dea1aa33c67cc4b2d11b241ac"
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
