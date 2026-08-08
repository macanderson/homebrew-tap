# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.11 / @SHA_*@ placeholders below with
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
  version "0.7.11"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.11/stella-0.7.11-aarch64-apple-darwin.tar.gz"
      sha256 "5f8bb85498b5db396f8f916bec7e9f52fce58c479ecf73fc7b0a770ffbca7edf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.11/stella-0.7.11-x86_64-apple-darwin.tar.gz"
      sha256 "d3865e233c9ce5d7cce19308c8fd23a46246fff773b42544a11f5d7602451d86"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.11/stella-0.7.11-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2cf9fbc57b3210688fbb8c61cb0453775fdf3212182f43870dec760a8d24efa1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.11/stella-0.7.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2a35e6cc6c8d9847b45cde137f654641d8537f8923d15a719b9ca7c6aa1c37b0"
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
