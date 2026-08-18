# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.96 / @SHA_*@ placeholders below with
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
  version "0.9.96"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.96/stella-0.9.96-aarch64-apple-darwin.tar.gz"
      sha256 "a39ef601b7250ab747fca099695cc4af5f9ed45ba89a1861992804c48f756daf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.96/stella-0.9.96-x86_64-apple-darwin.tar.gz"
      sha256 "950bc7e2954e1631ca27196c630f96d45dcc4f7096cf6a6a7fcc0986e6b3feed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.96/stella-0.9.96-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7e1f9deac2198d126663e03acde9de0d04c850a7140b4f5e843550fbc28c9fb3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.96/stella-0.9.96-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cc4430d4ecac4df15cf41cfdcc3be23006aeab9dd95cc27bd0bb2b6d30d389c3"
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
