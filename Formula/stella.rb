# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.106 / @SHA_*@ placeholders below with
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
  version "0.9.106"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.106/stella-0.9.106-aarch64-apple-darwin.tar.gz"
      sha256 "387d6eb1ed08716fbe0ec6d404e56be4ab87c4387a8d75ce1c00f18993c32d2c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.106/stella-0.9.106-x86_64-apple-darwin.tar.gz"
      sha256 "68d60cbd1541e388de8c55067bd99765efa4cab9f2700c362e2d35ad90ecafda"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.106/stella-0.9.106-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e10fd0b32b5d05c79fcd41bc43c849d69154f24fa49629775e288e1dbf29cdad"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.106/stella-0.9.106-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2101b9b05b13f7490182920d755c4de8c193ec157ba7154e165e3d335e7b2c12"
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
