# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.2 / @SHA_*@ placeholders below with
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
  version "0.7.2"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.2/stella-0.7.2-aarch64-apple-darwin.tar.gz"
      sha256 "014823855f99d16019dbdefdfb671b24d14e26a2c492ab9ec30c7b609be16443"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.2/stella-0.7.2-x86_64-apple-darwin.tar.gz"
      sha256 "8247fefe1b7df1d1b900ac2246ff61652b7b2539db231dac64e8233fb9ac74c4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.2/stella-0.7.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1f9d0ab86b9e705471332b465cc7127f287d0426f99365965fa7cf8e56d3a931"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.2/stella-0.7.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "95f33c18380519366c90147425408bda27c1448bd30474a3a2b94c1558e4d49f"
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
