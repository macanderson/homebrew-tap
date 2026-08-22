# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.135 / @SHA_*@ placeholders below with
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
  version "0.9.135"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.135/stella-0.9.135-aarch64-apple-darwin.tar.gz"
      sha256 "d30e9613015b459b2948b9cd627d31f48352f27390005d71f7cefcb6bf41ada1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.135/stella-0.9.135-x86_64-apple-darwin.tar.gz"
      sha256 "0d4d6158dbc43b8291d421e032ed1f85a28d8ab79936c473c04da72684800a10"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.135/stella-0.9.135-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a975b4653f6b977361e0dcb76ff4c12ab6e5f29ba2431794614a7237a923afb9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.135/stella-0.9.135-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c16a7805e1240cf598675c3e8357fda604f0c30230776c6feb74315cd90bc3ec"
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
