# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.457 / @SHA_*@ placeholders below with
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
  version "0.9.457"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.457/stella-0.9.457-aarch64-apple-darwin.tar.gz"
      sha256 "bfe9c3ff4986d9bf4a6813be850fd4945e116a24389f0814a43d1b64ee198d2a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.457/stella-0.9.457-x86_64-apple-darwin.tar.gz"
      sha256 "4567a750cc50f8934ac89d7ee146e8f2fc36d5fe32769ffdf3cd4b25bf7808a5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.457/stella-0.9.457-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1151f4228b021169a2f6a5a2b3247ca14ba8eb5e9991e0ec5e4dbfd79edd42da"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.457/stella-0.9.457-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a898d83c75461315c55f7cd6bb71ebe8b4443f101cec89f578dd2d352925bd7b"
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
