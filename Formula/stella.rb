# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.393 / @SHA_*@ placeholders below with
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
  version "0.9.393"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.393/stella-0.9.393-aarch64-apple-darwin.tar.gz"
      sha256 "41b66dd6c345f3eb63e630472b820fd58e989fa075396925d9c66e8b5466735e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.393/stella-0.9.393-x86_64-apple-darwin.tar.gz"
      sha256 "a0aa4d4f5926c3b1e79c8d4d6e3ed3f403a3ec7c445494886d6b492aba1b9299"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.393/stella-0.9.393-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "987045505b300abbdcb9647098fbcbca3c8e71a73f3966d198a400b4cbb95fdd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.393/stella-0.9.393-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "902ad2f7b5514a9f24c4ab7ff3f97af7ebf093b376410052f3a07564304a7aaf"
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
