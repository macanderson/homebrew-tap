# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.63 / @SHA_*@ placeholders below with
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
  version "0.5.63"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.63/stella-0.5.63-aarch64-apple-darwin.tar.gz"
      sha256 "9f694d4a3a9189854f361a5a95b1345c067ea41ee4f4332402c3202128b2d742"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.63/stella-0.5.63-x86_64-apple-darwin.tar.gz"
      sha256 "4d8fbc885a8bb53c024f24885499275249cb749682969e7578756958281c1e61"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.63/stella-0.5.63-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "95dc6a8ec3292256f05715e9db8fcc247265a807246a794a7680e89aa181b929"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.63/stella-0.5.63-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "38c674a22ae7909f5332d67cfa14c109a7cb165782439f0943f2cd0a565c0bdd"
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
