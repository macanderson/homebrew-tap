# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.114 / @SHA_*@ placeholders below with
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
  version "0.6.114"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.114/stella-0.6.114-aarch64-apple-darwin.tar.gz"
      sha256 "067c640a988be2e178d807faef5a559b83f239ba2b25f84dfe0d03e1185a0306"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.114/stella-0.6.114-x86_64-apple-darwin.tar.gz"
      sha256 "010a6a32f8ac2a22f35a85d39618b7aa982ba3f8e4c2f10e2d79412d37f1131a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.114/stella-0.6.114-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c4c3b3aef65c5d4cdc405a10e215769604e281f2405bb4eb75798792e81b5c0e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.114/stella-0.6.114-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0a44bd471151d536a8134d76d71d24805d48d35bab59048509286441338473f3"
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
