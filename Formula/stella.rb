# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.496 / @SHA_*@ placeholders below with
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
  version "0.9.496"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.496/stella-0.9.496-aarch64-apple-darwin.tar.gz"
      sha256 "953c445bb220cf3653c0820a40b6477f412df56fe156b8b613a4b833949355f9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.496/stella-0.9.496-x86_64-apple-darwin.tar.gz"
      sha256 "3e9118a1448c354cf63681e7240f8721fc058ae3db91faf8f553b4db125e1499"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.496/stella-0.9.496-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c4c259c4aefd51ac883b251efb28b33868f1d8d005f7ec7a67f2981d0bc13924"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.496/stella-0.9.496-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "24836311e19e9dec3d9fa9a7dd8826be1e4d59d5b4d8210367d6461701a55cd3"
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
