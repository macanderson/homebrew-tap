# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.297 / @SHA_*@ placeholders below with
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
  version "0.9.297"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.297/stella-0.9.297-aarch64-apple-darwin.tar.gz"
      sha256 "b46c260445c55ee80fd9e4ac050f3975d7f27d2148ef19c1a64b4575d12e867d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.297/stella-0.9.297-x86_64-apple-darwin.tar.gz"
      sha256 "5c02c433d66791afb696163999111799aa9be5ac81cb2da9f99e6d119838ef64"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.297/stella-0.9.297-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e325829f6b2432c0a1ef6a760f136be108320057b28f8dea8e4ad051e832f264"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.297/stella-0.9.297-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5fa5d93fdea5dc30efe3c7517d64710c215bc40b7c8c3dd68eb1a899a76d0250"
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
