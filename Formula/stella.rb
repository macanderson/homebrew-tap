# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.45 / @SHA_*@ placeholders below with
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
  version "0.8.45"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.45/stella-0.8.45-aarch64-apple-darwin.tar.gz"
      sha256 "c198e425393ed51c0cc8ce96a7814c0640cdbce1f83c00c9d5865622eab5299f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.45/stella-0.8.45-x86_64-apple-darwin.tar.gz"
      sha256 "b6888c00b09ae931d944e3be5b5e2d96d7c64e4875b0b402455e6f41080f6088"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.45/stella-0.8.45-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a3d8d2cc0181d0655a1c3956bfc99862dfdffe8b1e3998242477a90521fd6749"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.45/stella-0.8.45-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "21f7688a2effb781aa4540d1e108dccc1a15f8fd6384265c97ab14239dd43fdc"
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
