# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.44 / @SHA_*@ placeholders below with
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
  version "0.8.44"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.44/stella-0.8.44-aarch64-apple-darwin.tar.gz"
      sha256 "107e721edd9ebc259fedf0f3083de481a6db767af62fa841db56b2412b447985"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.44/stella-0.8.44-x86_64-apple-darwin.tar.gz"
      sha256 "eec3cf79e21ab5d6daba977638f27904969168ed335277521d5806c9fe130ef2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.44/stella-0.8.44-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "382f08cd219071fde5f25dbebb7e089c71545c1f37a453cd93d7041d99c992ce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.44/stella-0.8.44-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "34ea5f3ea3d752c45959807f72fce84fa6afd3a1d12c22815f2b12f18594d68c"
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
