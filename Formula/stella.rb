# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.41 / @SHA_*@ placeholders below with
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
  version "0.6.41"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.41/stella-0.6.41-aarch64-apple-darwin.tar.gz"
      sha256 "4b0c755314059f8876a310accec4fe7ec801bff209142c745d908d9d7b9030ed"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.41/stella-0.6.41-x86_64-apple-darwin.tar.gz"
      sha256 "0cc53dce97e543fe2b25ee3efacfa070dedafb138c0c6d18e6d90cc5dbb7ac47"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.41/stella-0.6.41-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "650447806d2eb64d6749a533a095ac32162a724152de7680a48954fcb6207c4c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.41/stella-0.6.41-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c54d9c8b85a8ed3134f9396cd0746a9612ab0ff2a0e8b93b149c12b05bb6be86"
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
