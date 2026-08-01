# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.57 / @SHA_*@ placeholders below with
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
  version "0.6.57"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.57/stella-0.6.57-aarch64-apple-darwin.tar.gz"
      sha256 "8a3ebfafbc595e4110fb82dc095e4e685a45cfad88e3806f0ed2c6211066a6f7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.57/stella-0.6.57-x86_64-apple-darwin.tar.gz"
      sha256 "eb580f7a70285edbe3fc78e3dbf3acb25f5e64e0c08c301c7646b8ff60f3902b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.57/stella-0.6.57-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a1fd6d4a30e1847f427e293177a42b2f31cbb0fbb3bc9f09b74502bd8a045a62"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.57/stella-0.6.57-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cb71d8ca31f78f2cbf32904b4a41359ba1f10ad8c5bb31212d44c9a7c8332056"
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
