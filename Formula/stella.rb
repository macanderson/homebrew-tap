# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.455 / @SHA_*@ placeholders below with
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
  version "0.9.455"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.455/stella-0.9.455-aarch64-apple-darwin.tar.gz"
      sha256 "a346b0518aa8140abca051db2b3f7d58e1b2e2755ced087242752c1e085af0bb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.455/stella-0.9.455-x86_64-apple-darwin.tar.gz"
      sha256 "9372635296c3d9f1135a78d664ca1096170cf7e1da90587407968c5fc6377367"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.455/stella-0.9.455-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "72df8c9c720c10fe0f039e3bacc603dc847b42fa8f7e086f1e325b3f92a433fe"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.455/stella-0.9.455-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eaf9257d3311dd839db47402779650f5a31977a1fec5606490c90d466c977b9e"
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
