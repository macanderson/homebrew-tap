# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.7 / @SHA_*@ placeholders below with
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
  version "0.9.7"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.7/stella-0.9.7-aarch64-apple-darwin.tar.gz"
      sha256 "a3ece98b31bb756277e3252dfce762306e4f933c788c3c77f5ad447c1df904bc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.7/stella-0.9.7-x86_64-apple-darwin.tar.gz"
      sha256 "7b8b652e0769e9d946dadd7058679c8248965cba6c359d906c73ca5f59643048"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.7/stella-0.9.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e74530377cca0da8d52b67a4d86adabbdd97a674b7c06d13ec12be2a61bc0f85"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.7/stella-0.9.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1225b43e1a6093d92e17647b8afc311c1bbd29afa8fdda5fb5d2b0e158b06b98"
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
