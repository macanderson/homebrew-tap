# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.133 / @SHA_*@ placeholders below with
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
  version "0.6.133"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.133/stella-0.6.133-aarch64-apple-darwin.tar.gz"
      sha256 "27df35240ecbc2cefa9aeedf627fee9043c6e33b0f399ffbd0854f7656c609a0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.133/stella-0.6.133-x86_64-apple-darwin.tar.gz"
      sha256 "9f609f78a4f8c31e63b8ef1bfecab7819cfdca0bbd3d4065d2d475855105e408"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.133/stella-0.6.133-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "94cc4058bd6ab10c5e62d07194fd5b98818cad3fe89faa0378cf0c80082f0fb8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.133/stella-0.6.133-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0010cd9afd37ce60446fe1df43ec8804e4a1e065a37f6dcfdaa05c3591e3f9eb"
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
