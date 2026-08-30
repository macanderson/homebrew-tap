# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.278 / @SHA_*@ placeholders below with
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
  version "0.9.278"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.278/stella-0.9.278-aarch64-apple-darwin.tar.gz"
      sha256 "72bf8074a0a267285fea981d3e4aeaa5a4c445f1b0c345b5b7e80e85e52a13ce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.278/stella-0.9.278-x86_64-apple-darwin.tar.gz"
      sha256 "1a4f552baf5ad4e56a0246beed3d7ee312bece5d1e294427366a9e46494e190b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.278/stella-0.9.278-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7118236ef998d2c95d9ed806b6dc9afa7d1427f72b1178ae5c242bad3894e0c6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.278/stella-0.9.278-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2bff048b3d8f8752028a5a878c087d0a91c4198d8b9f816345615787c9230d0b"
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
