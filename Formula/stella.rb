# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.458 / @SHA_*@ placeholders below with
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
  version "0.9.458"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.458/stella-0.9.458-aarch64-apple-darwin.tar.gz"
      sha256 "9522815fe9a05267be96566976d127c1aea4b114f17c018a50e311ac2c4d5441"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.458/stella-0.9.458-x86_64-apple-darwin.tar.gz"
      sha256 "4f07ba3663a8a8cc869407793060c099079a3365d04774f19a0aae6ce7f2b6cb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.458/stella-0.9.458-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "97fcb35b701f04c5b551c3f26c6569aa395bcde41919092e8e4d9399f215afe1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.458/stella-0.9.458-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4d188dfe583f0795fbec7fa02d2af028519d7682ec13b05a3871ceb357d9a6e7"
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
