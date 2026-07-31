# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.24 / @SHA_*@ placeholders below with
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
  version "0.6.24"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.24/stella-0.6.24-aarch64-apple-darwin.tar.gz"
      sha256 "4ae7a29e89d5967f7688ba4a44f3ed89167ec1669e4c90601c65d26857b179b2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.24/stella-0.6.24-x86_64-apple-darwin.tar.gz"
      sha256 "ffcf1100d9c33e8bbf9d4740cb80aebd7602439f68df86eb1cdc150eb8f7d52f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.24/stella-0.6.24-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b5dd2276fa210a087d5107aea43984f38c32cbc6e2abf24d8d65c34e8db9d96c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.24/stella-0.6.24-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8f3df27a484fde327431ac91cd15869f06d5a05bb383c6e68f363a46fb8951bb"
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
