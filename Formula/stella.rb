# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.32 / @SHA_*@ placeholders below with
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
  version "0.5.32"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.32/stella-0.5.32-aarch64-apple-darwin.tar.gz"
      sha256 "0f8d0c1f3fd66637cdff3dda618db2e4489757e63d741a422c643a3e9c8491f8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.32/stella-0.5.32-x86_64-apple-darwin.tar.gz"
      sha256 "f8be62eab2fc652586ab02b6c9fdbca980c6bc0301d2fef35fb784ea4b5e34f4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.32/stella-0.5.32-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8be298b997b9ab811582b1ddb56dd9505b4752d1996b5e0acbc227e3a0bb5f68"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.32/stella-0.5.32-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "622c5ed6b003dc8d7687ec2d374a68ebe6cc493412d504b6127a575306c1f7db"
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
