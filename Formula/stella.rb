# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.111 / @SHA_*@ placeholders below with
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
  version "0.6.111"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.111/stella-0.6.111-aarch64-apple-darwin.tar.gz"
      sha256 "2637711761de37f0f9bb74076171af5ad50eb984dc64f36777a0c49be54aca7e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.111/stella-0.6.111-x86_64-apple-darwin.tar.gz"
      sha256 "5c50b5acd98affe00f1dc9a1104b9822b1ca97a8b249e9e04d422c355350195d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.111/stella-0.6.111-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8fa3069ec4dad75ce212a8f333bb89c59b3f657a308c4baa55234e486d77594f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.111/stella-0.6.111-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7083913638efc14a51080a47f24a0d0c3deab79fdad9b4a351d75c3c072a965c"
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
