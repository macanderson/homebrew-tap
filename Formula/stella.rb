# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.28 / @SHA_*@ placeholders below with
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
  version "0.7.28"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.28/stella-0.7.28-aarch64-apple-darwin.tar.gz"
      sha256 "1aa9313e2179e4208ae1abfa059372f376c588fa5258d58b4bf629a73d19c8f6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.28/stella-0.7.28-x86_64-apple-darwin.tar.gz"
      sha256 "4c8a1b622ea1c3262ff91cfcdb17b527468f387349cbceb973277ee9f0c6de07"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.28/stella-0.7.28-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5722ed6770c79747a10c86f0aba51dffe392d89e402ba9bfebb2479e98cc3403"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.28/stella-0.7.28-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4376249da8da4ac183399f1ad7bf91efcaddd789fb5c9ceafbc2e3f443f9109e"
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
