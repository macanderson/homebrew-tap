# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.353 / @SHA_*@ placeholders below with
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
  version "0.9.353"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.353/stella-0.9.353-aarch64-apple-darwin.tar.gz"
      sha256 "757005d43264cae3b85a257c1adafa8e0daec18a005e60150353e4423c9d715a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.353/stella-0.9.353-x86_64-apple-darwin.tar.gz"
      sha256 "b30c7429af9fea98ae2f1331a045debd4aadb7cccbfe7fc19bb1c15c8228788e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.353/stella-0.9.353-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fd264690566cca2d5fd85a5f793188c2d4e71da01361d2f7dcf5023559ed0f3a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.353/stella-0.9.353-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a1249f962a37eda0ed6d5008ecc837ff2451e01fc13eedd970a2a681157d898c"
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
