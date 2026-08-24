# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.183 / @SHA_*@ placeholders below with
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
  version "0.9.183"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.183/stella-0.9.183-aarch64-apple-darwin.tar.gz"
      sha256 "e8379505665e257894bb8350bcdb6c2d46094818b04962a17b3279194303d41f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.183/stella-0.9.183-x86_64-apple-darwin.tar.gz"
      sha256 "a6057792347c76abbf1e5eeb59713d39390e1a84781a56c4b62767cf9840ebfc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.183/stella-0.9.183-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0c2efea06b47390d0fd456b65927c928b8fbd39b7740df6177ad1b18f19fd60a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.183/stella-0.9.183-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bd30057de6c12e7ba2c12e219771dbf2a26e154200d3d9bc44f2f1277dfd71f7"
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
