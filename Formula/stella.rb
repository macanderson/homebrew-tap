# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.244 / @SHA_*@ placeholders below with
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
  version "0.9.244"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.244/stella-0.9.244-aarch64-apple-darwin.tar.gz"
      sha256 "741033f716cb1db8f454325afe60478bb353f915b6c1b494a8098c9926456ccd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.244/stella-0.9.244-x86_64-apple-darwin.tar.gz"
      sha256 "1654028b353bc8a6133f44fff5609e552cfe427ffb084a32d094529a8af21e8c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.244/stella-0.9.244-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dad906a6be10d7bfc2d2e758a0da653501ffe48bc18d22b8068230d47a74ce22"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.244/stella-0.9.244-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b19319524e9193c4f7213c56ecca95c81c17ee2a84f841e1fe4860582b60aef4"
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
