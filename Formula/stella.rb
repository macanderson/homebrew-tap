# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.33 / @SHA_*@ placeholders below with
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
  version "0.8.33"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.33/stella-0.8.33-aarch64-apple-darwin.tar.gz"
      sha256 "828c52c19135ad71beef2e13df2978606a71bc6b3f8af52e8a924bbf877c6e93"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.33/stella-0.8.33-x86_64-apple-darwin.tar.gz"
      sha256 "8756b75219dc0bf8aecfdb96ab79964e7a1b84c76032a0e4ea9bc57c629df326"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.33/stella-0.8.33-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "138d4cab930c8c6ed5e13397f952728ea5b2c14ec9705850f4aae63ad347fbda"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.33/stella-0.8.33-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "28cb4c98b45287fc20642981df53005a8d1d6c43ac840237d45f8e1492c95b58"
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
