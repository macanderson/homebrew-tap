# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.10 / @SHA_*@ placeholders below with
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
  version "0.9.10"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.10/stella-0.9.10-aarch64-apple-darwin.tar.gz"
      sha256 "8ebbebc1189c045933f85d7069961c67c75766f17c4d773ef1a29d490c91590d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.10/stella-0.9.10-x86_64-apple-darwin.tar.gz"
      sha256 "226dd8db0ce2e108d08f8cbe372cdb6b4bb2afb05a2e1b41a15a205d34c7901b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.10/stella-0.9.10-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "00e36659bff160fd29f733ba8ebdff1b91b0f44f6d32c0dddbcca6c1c281ad60"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.10/stella-0.9.10-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b86c301729f2b3170e5a2e78fd8ebbf44a355dae8f0fe283df7894370f6c7781"
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
