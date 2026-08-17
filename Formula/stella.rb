# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.73 / @SHA_*@ placeholders below with
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
  version "0.9.73"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.73/stella-0.9.73-aarch64-apple-darwin.tar.gz"
      sha256 "8d868632c2c62d62a8bb92dfdd4699cecb4eb573e519044ad14741d6dc3c2888"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.73/stella-0.9.73-x86_64-apple-darwin.tar.gz"
      sha256 "743ebf1fce38d30cb118dacfd66610a6a167fa37bbe82693004d5efa20f0bbcc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.73/stella-0.9.73-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f17f2c7d93b3c8796a46ceba4632bb47a94f64fcadfe43c0d487cb192d665e3a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.73/stella-0.9.73-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "20078e48f33bad7f8b437d496128fa69b70934db68475bd50e5180f55c71f8d1"
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
