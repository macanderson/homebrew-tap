# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.171 / @SHA_*@ placeholders below with
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
  version "0.9.171"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.171/stella-0.9.171-aarch64-apple-darwin.tar.gz"
      sha256 "23a1967e59674c11902dbaa3575879480b55a6a277c37d87d113d35c53105e88"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.171/stella-0.9.171-x86_64-apple-darwin.tar.gz"
      sha256 "b0d97a41b63f7245a5766348b94c74cbd8c9482210641f5099cf22ac2c7de769"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.171/stella-0.9.171-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ecc9eccdc3cbd8da44d21110659cf59c387644aa4df30fea86242710cd53e848"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.171/stella-0.9.171-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a288c52f90ba612f37665f9e038e3df99a49a8b06c6facc632a0f04b1cb9f1c4"
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
