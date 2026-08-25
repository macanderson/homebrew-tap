# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.209 / @SHA_*@ placeholders below with
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
  version "0.9.209"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.209/stella-0.9.209-aarch64-apple-darwin.tar.gz"
      sha256 "84ef5b32bf3ea2b38bfbd5c57b9b478c0a27bf9e9ab962fae8f7fcc91ccc0697"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.209/stella-0.9.209-x86_64-apple-darwin.tar.gz"
      sha256 "24a89f140bc1a6aa27fc63822d7b15c39d30f27ba47b7fcf18de5a2a6e5c540e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.209/stella-0.9.209-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9e95a86172e99a0cbb78d7e27cb4a5a4c52edad60370d62a6b6612efc2e366fa"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.209/stella-0.9.209-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ae2d43d019e769d060744129249571c6917dc6f7eabd103a7be0f8297286e65f"
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
