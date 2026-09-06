# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.373 / @SHA_*@ placeholders below with
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
  version "0.9.373"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.373/stella-0.9.373-aarch64-apple-darwin.tar.gz"
      sha256 "0ae29b8d68705006d4838b988f9348685191e9a8699b3a38ea88ed8d0eef58c3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.373/stella-0.9.373-x86_64-apple-darwin.tar.gz"
      sha256 "2739d0b1880bf52aa8ea838417e097d937da65a4d651d32cbe0a96b045f9290a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.373/stella-0.9.373-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "484b05b56cc4df6abe163d35373c0039d4426fc99f1081737f7aa05e44e5c119"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.373/stella-0.9.373-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3800b1b7faef4398078c9d57115e1ee0de9167820ec84b9ae40379e377945b21"
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
