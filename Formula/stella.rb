# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.42 / @SHA_*@ placeholders below with
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
  version "0.6.42"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.42/stella-0.6.42-aarch64-apple-darwin.tar.gz"
      sha256 "f9cd38c6b3088049a1a175ac8a45d30e345d9d1805412d84378c68f1dbf42601"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.42/stella-0.6.42-x86_64-apple-darwin.tar.gz"
      sha256 "9eec8efac6b9149ef6d92cbf10d82ce2471c988249ca2e31c5043b17663e3834"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.42/stella-0.6.42-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fee21cf8f0d9972509e314506ca5b8af30a706e073689bbed849f3a8ea508267"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.42/stella-0.6.42-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d906f5c53e23f1eac594aff4719a444b8b47b7ed2fe0346b2d738c0aa91425fb"
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
