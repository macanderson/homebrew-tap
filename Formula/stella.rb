# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.208 / @SHA_*@ placeholders below with
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
  version "0.9.208"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.208/stella-0.9.208-aarch64-apple-darwin.tar.gz"
      sha256 "63cbe61d129fdd2e7485e4de6d91b7833c04c84e88fb52448540e1b10b2dfe41"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.208/stella-0.9.208-x86_64-apple-darwin.tar.gz"
      sha256 "0a99b720e0f297669433425273b0b6ada1358459fd431780cd0791a90bccd580"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.208/stella-0.9.208-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b067bc1d6988bd2febc9a39dbad9e175bcb507db901a94a8e142719d8c3ab646"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.208/stella-0.9.208-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "89a1c5e234a9513d969ad2115f649745be0db5329750a0af25f63a36a3aac6d5"
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
