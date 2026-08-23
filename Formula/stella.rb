# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.149 / @SHA_*@ placeholders below with
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
  version "0.9.149"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.149/stella-0.9.149-aarch64-apple-darwin.tar.gz"
      sha256 "0f5852ebc326290efb489576da69332913db02a09466d7dcb8d3db8676bea043"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.149/stella-0.9.149-x86_64-apple-darwin.tar.gz"
      sha256 "5c996636cd6f1b4815bd3a1cead7ac0f422f8a51c806490f7ef5050fbe547d34"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.149/stella-0.9.149-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "411bbf0671be9ca1d6ce0bfdb9092824d3745bd99750a5a00bc1ba553142bbc4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.149/stella-0.9.149-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "407d190310bc5bc843e04180e297dfa8e7d6e9c651fe72f1c08c637d8cef61ac"
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
