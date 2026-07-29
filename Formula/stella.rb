# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.1 / @SHA_*@ placeholders below with
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
  version "0.6.1"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.1/stella-0.6.1-aarch64-apple-darwin.tar.gz"
      sha256 "4dc1d327b44ac74e552dfececb852807730678dd06936adaf40f338d5826d004"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.1/stella-0.6.1-x86_64-apple-darwin.tar.gz"
      sha256 "b6622252becfc2233614447b5a4949ec726fc1c7dce84f0c57b2ebffb7d3923c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.1/stella-0.6.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a483c491d0eacce8ce981d2cb513d9314ca4a49a664b7b66e77ca66d251b8a1e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.1/stella-0.6.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4c54acdfedb93b330bebc7eca0cf9821fcce97bbadac102280dc04c588371a4a"
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
