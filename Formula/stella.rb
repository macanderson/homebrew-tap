# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.282 / @SHA_*@ placeholders below with
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
  version "0.9.282"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.282/stella-0.9.282-aarch64-apple-darwin.tar.gz"
      sha256 "5de9626fe75b09ac2c5878547643b9727e37eb41f1b9914a94832710cdd56b3d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.282/stella-0.9.282-x86_64-apple-darwin.tar.gz"
      sha256 "c3760a6686e07d8ea1c997be003283e01af3f86c99a64615a56b127bf55f0c8c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.282/stella-0.9.282-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "891135adee69dcb2afab158a8ab98dfe98219c1e9e4aac2124849ade73001c58"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.282/stella-0.9.282-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c2db6a82ba9132f66011afcfc7abae90943c44f16c36ec7caa7a1a2574b6d4f6"
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
