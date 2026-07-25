# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.19 / @SHA_*@ placeholders below with
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
  version "0.5.19"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.19/stella-0.5.19-aarch64-apple-darwin.tar.gz"
      sha256 "5ad47a41968f8036636c5e7313af88d4b695f83f5157d64d27e2e30f8323d54a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.19/stella-0.5.19-x86_64-apple-darwin.tar.gz"
      sha256 "f65ce0853802a3822b0ddff0c4aeef23247f3f3b25f53c41e05abd5100596b01"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.19/stella-0.5.19-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "33698e9b2ae19aece34458a2ba971be64c3bab6eb6b55b304c3656713c829cb0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.19/stella-0.5.19-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5bb84b42de01cbb03704c50b74df642272cfb713682fee6a423b935a3992ed30"
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
