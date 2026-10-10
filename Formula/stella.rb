# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.488 / @SHA_*@ placeholders below with
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
  version "0.9.488"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.488/stella-0.9.488-aarch64-apple-darwin.tar.gz"
      sha256 "9d9d1192a4fbe0d34fd8d2f3638d23efe159bc180f6f6d5082ec3b8fca457350"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.488/stella-0.9.488-x86_64-apple-darwin.tar.gz"
      sha256 "958f73f2a009c3e6c0cfbc058c287bf75559378885cf4e101b9b6c2b6c09f04e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.488/stella-0.9.488-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b174b71599ddf87bc76f16db33aa4bdc2f67f32547d370eae3dabe6dcb571395"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.488/stella-0.9.488-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "134b279346b69b2479b773a09e0448e31f750e879828ebf31f736871838ba32d"
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
