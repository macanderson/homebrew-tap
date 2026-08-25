# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.212 / @SHA_*@ placeholders below with
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
  version "0.9.212"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.212/stella-0.9.212-aarch64-apple-darwin.tar.gz"
      sha256 "828c3f475b86f8ceed9427445a64b8ab38201daa58f3db4352206a3d9bfc8961"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.212/stella-0.9.212-x86_64-apple-darwin.tar.gz"
      sha256 "0d4f2b9842f75fbb3729105fa8665c87ed8f394400afa0f8b3f01190b48ef066"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.212/stella-0.9.212-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "68b9d09ae1ef705006aa3b3fb197f6de8e2df5229ac875ed5fcc8020b994af1f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.212/stella-0.9.212-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "762293126552173a1e6528697edf4c457ebb94d83a4b681e227776d4948becad"
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
