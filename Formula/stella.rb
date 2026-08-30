# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.280 / @SHA_*@ placeholders below with
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
  version "0.9.280"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.280/stella-0.9.280-aarch64-apple-darwin.tar.gz"
      sha256 "686829a37146040cbeea830bfc03c9a8d726725b188dd6a37a77fb9afba7695a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.280/stella-0.9.280-x86_64-apple-darwin.tar.gz"
      sha256 "20448e8ccd7643e1ee9d77c014cbaa22132f7bb336564577710f6a34d4eaf3fa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.280/stella-0.9.280-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "268a4f4ec9efde05c5f36fb128d04b9e68f4392ace6d3d80ac8c1710e0a93447"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.280/stella-0.9.280-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fd0a8d39ba4f4c90f08e63241ecbb1322c07e313ef9e26e704635763a0e7295f"
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
