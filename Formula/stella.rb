# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.180 / @SHA_*@ placeholders below with
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
  version "0.9.180"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.180/stella-0.9.180-aarch64-apple-darwin.tar.gz"
      sha256 "b71c5e3df1b8c1e029d9a59e8945c31949a0655b1405f4bf7c2cab3808f3bcf2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.180/stella-0.9.180-x86_64-apple-darwin.tar.gz"
      sha256 "7881d6aa5666406e571b27755ad768d275af7aaf85edeec6207163aee1cbf8ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.180/stella-0.9.180-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8cc60cea1ad3f77056a228d610ad1955f87a9d6c629a0d212e596f2d9a665993"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.180/stella-0.9.180-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d85ca5359844ea63c20888d71294e10cf3ccff9c8eeeb2b310a9aa6f0a7e688f"
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
