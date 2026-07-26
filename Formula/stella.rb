# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.33 / @SHA_*@ placeholders below with
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
  version "0.5.33"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.33/stella-0.5.33-aarch64-apple-darwin.tar.gz"
      sha256 "0b6d163292be8a376cf890feb95c9fed2983dd07623097f1f099718c06c1b4ba"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.33/stella-0.5.33-x86_64-apple-darwin.tar.gz"
      sha256 "7abfacb6115fcfb836f25bd8a1fb19f12385ec18640f528fc72e60fa84d5f4d7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.33/stella-0.5.33-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a5f757bfb398133d552226937170ccf701f92fae79ffd6c3d00f7c6cbd9e54c4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.33/stella-0.5.33-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c3ca6185ea794b26e3aa0e3bf7ba4d788c0317dcd4e661d2b180b91cad674b5e"
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
