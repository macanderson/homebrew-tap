# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.370 / @SHA_*@ placeholders below with
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
  version "0.9.370"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.370/stella-0.9.370-aarch64-apple-darwin.tar.gz"
      sha256 "b251e70c5c7edd664cf07711ee790cd8db39c23b74a935b6d909ec2bb6b3b708"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.370/stella-0.9.370-x86_64-apple-darwin.tar.gz"
      sha256 "3d86282efa5865f67be66af0d26cb24e8a1beb5e55cc2146393100bc89e91cf0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.370/stella-0.9.370-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9ef66d0b684c80746fa768b91bcbb394f2706976afb30ed942c62ef29446fe6a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.370/stella-0.9.370-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e9fe79f08ca5ceb9b627a3eaf4479c9e86f40a6c3f9b645ca2bf14de2d345a5b"
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
