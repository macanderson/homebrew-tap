# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.346 / @SHA_*@ placeholders below with
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
  version "0.9.346"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.346/stella-0.9.346-aarch64-apple-darwin.tar.gz"
      sha256 "27e977f12b782e266496b3375185711a3d6257ac211d7cf55891aaeb3a1f6a1f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.346/stella-0.9.346-x86_64-apple-darwin.tar.gz"
      sha256 "562d12ef3f4983a7cffdab4e428b828a2f14c6e9e18e8571f7f3102c4c5de189"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.346/stella-0.9.346-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "728f53c20e763e497155cc74c64c31a16ecda66b6909eb66430fe26083359d25"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.346/stella-0.9.346-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6d615527b071dc04e4e642d53d10025d7f07cc0a4af558c83c11ce192a9cab71"
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
