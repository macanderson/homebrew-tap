# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.321 / @SHA_*@ placeholders below with
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
  version "0.9.321"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.321/stella-0.9.321-aarch64-apple-darwin.tar.gz"
      sha256 "0fed50328b21306aa2ba8676e22382b752c0cab74b2b8a7bba02cbf7c65656a5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.321/stella-0.9.321-x86_64-apple-darwin.tar.gz"
      sha256 "af63dc52c25442830c03abb54035c78391965201ef0832606d56d41a097f02b1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.321/stella-0.9.321-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3f8984b04bb1b7092f73b0ed74a0c736e55992856fb37947f054c2d2de649893"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.321/stella-0.9.321-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "42986423501f311d9de1a569aa43198c7f9d7d07fb5238ba1d8610f16c5884a7"
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
