# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.17 / @SHA_*@ placeholders below with
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
  version "0.7.17"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.17/stella-0.7.17-aarch64-apple-darwin.tar.gz"
      sha256 "322badc3f583b725e3cbabd829061400027b6672201918b0c40a7fd28442cb7a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.17/stella-0.7.17-x86_64-apple-darwin.tar.gz"
      sha256 "4b76c9a7f99cbe3593474529599020f61c1e8a6309c47e7268bb1dbb1b5cf9ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.17/stella-0.7.17-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b498d8dfba22c3b04f9abc9b52a190128552eb5a4a700016c5ed2806be07e843"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.17/stella-0.7.17-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c5676ae5dfe632557d3f5eeb0a6a3d8d56a2edcbd098b7e4334585b96faae03b"
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
