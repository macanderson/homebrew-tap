# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.56 / @SHA_*@ placeholders below with
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
  version "0.9.56"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.56/stella-0.9.56-aarch64-apple-darwin.tar.gz"
      sha256 "2f315b4e6a7f2b9656f69de8c2aedfd3966221179db39418b72d5f140e76982d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.56/stella-0.9.56-x86_64-apple-darwin.tar.gz"
      sha256 "b62793bf6365c21595469dcca60e9fd662dddb8b8c598f52fd70f728e209e812"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.56/stella-0.9.56-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0402e1983a71297aac21daa9bc73eeda8ae44b7e5b0aa5dc0d2554009710ee13"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.56/stella-0.9.56-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4bdbde8a98d0265ddfd8164e1f77a91fa2393093921dddf3b1fe6cb60fd04ade"
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
