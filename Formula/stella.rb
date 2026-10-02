# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.467 / @SHA_*@ placeholders below with
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
  version "0.9.467"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.467/stella-0.9.467-aarch64-apple-darwin.tar.gz"
      sha256 "1e0085192134fd4028c4ace365d86d4c9aa22b550deffaa0f858e396da16bcf0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.467/stella-0.9.467-x86_64-apple-darwin.tar.gz"
      sha256 "35a3035df33cfa8994b2b1a51e8d452ac166061e2503a55fb63af292ce21c95d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.467/stella-0.9.467-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4ff5869c759a31119ba8faba64370649da5625eb7fea4cca1ef8c6d82059bf44"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.467/stella-0.9.467-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d6ed7e9e5bbd6e1f152ef8e3f00f38f63307530a887df4d6a5d4bb18b66eaaad"
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
