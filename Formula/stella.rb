# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.356 / @SHA_*@ placeholders below with
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
  version "0.9.356"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.356/stella-0.9.356-aarch64-apple-darwin.tar.gz"
      sha256 "ea48bc54aa0131fd50e1ceee7d026f4ddf0fde2a34bb0699335c9d9127271fb2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.356/stella-0.9.356-x86_64-apple-darwin.tar.gz"
      sha256 "ad870d8a5e800ac4687c8030d6e0257313aaaf9065916630a791ad7a7f27df16"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.356/stella-0.9.356-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c07361f51bd62a05faeb0f82540f19d23cad68431d3277099c4f60ed15a6299a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.356/stella-0.9.356-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d615283c20ff6bf0c5082a63aeeaf44bc451b80d8c9fbdd80d50b5e543c7e13c"
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
