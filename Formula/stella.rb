# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.50 / @SHA_*@ placeholders below with
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
  version "0.6.50"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.50/stella-0.6.50-aarch64-apple-darwin.tar.gz"
      sha256 "612d716cbf2d5b6e6540b5f12fa6c317554e13672233faa9c590808a49da6e9d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.50/stella-0.6.50-x86_64-apple-darwin.tar.gz"
      sha256 "3e2fd8bce2f1eeaa95ec1cdcf2e014988d8a4b5dd42befbb67cf69bebdd380a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.50/stella-0.6.50-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bccab0a9c23372a89b4a9e7069ad54197a91612ca09aa3d7633005f2328a26b8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.50/stella-0.6.50-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0eb2ffaa8a9fec63ec6882f4132fa535538e5682664ec1306ad6b1b7a6a7fdea"
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
