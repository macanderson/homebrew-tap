# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.167 / @SHA_*@ placeholders below with
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
  version "0.9.167"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.167/stella-0.9.167-aarch64-apple-darwin.tar.gz"
      sha256 "3b11ba9864c0b42772bb1f22123a80c5465875e9c19752077220f448175e15f8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.167/stella-0.9.167-x86_64-apple-darwin.tar.gz"
      sha256 "b17d0db3dae182edb38ebd22e2bf63f57f39bc5944ed38df89040c120455195f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.167/stella-0.9.167-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ec709b4650ea9ef7176e46393f007aa8222d18787532f57ef0c192e1bf6fbd29"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.167/stella-0.9.167-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "95a0cd42cfaede5c17f45d23b5a8ca38d48c98991c80d10dfb7566f780723358"
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
