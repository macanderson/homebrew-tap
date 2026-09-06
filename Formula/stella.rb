# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.374 / @SHA_*@ placeholders below with
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
  version "0.9.374"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.374/stella-0.9.374-aarch64-apple-darwin.tar.gz"
      sha256 "a1ec095450cffab5eda512a010946d61bfbe083eeed2e2e6142b096b09b5db23"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.374/stella-0.9.374-x86_64-apple-darwin.tar.gz"
      sha256 "e27dbceebba910d3c2f9156b4ecd0b27fda654370be653d4c558b1dd9efb7654"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.374/stella-0.9.374-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8672036db356cc9bca02a65d7af2081e3aeffa5527a45fe355f2c217f5553595"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.374/stella-0.9.374-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "89dd2049e45067f84b006a64c61f052a8403d4feedd1bc4a127b1e59307472dd"
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
