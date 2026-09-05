# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.337 / @SHA_*@ placeholders below with
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
  version "0.9.337"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.337/stella-0.9.337-aarch64-apple-darwin.tar.gz"
      sha256 "cd4485bbfd04c7eee0fe8babeffa70aac95f9d77491014481c5f869c96246118"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.337/stella-0.9.337-x86_64-apple-darwin.tar.gz"
      sha256 "6f01bdd78b6b8c59e57473654f5e2ceaafb040cdc89defc3eed8d6d3451dd374"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.337/stella-0.9.337-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "93d595bc9eb01a615fd4841213c9a6f36061038c55103bed0f9459de986f86ce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.337/stella-0.9.337-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6855dc855453ae32e580d90bd9ef8f2c7a6527af7f104fdbe47174545396bc70"
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
