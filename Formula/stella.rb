# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.347 / @SHA_*@ placeholders below with
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
  version "0.9.347"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.347/stella-0.9.347-aarch64-apple-darwin.tar.gz"
      sha256 "e3535296aa0f1d8121d321636abc77dbede6b9ef45f0d1e03c6eab23e965a59d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.347/stella-0.9.347-x86_64-apple-darwin.tar.gz"
      sha256 "646ec85ea90e315cca7df1c0cdd9368ad66f9e294d84c046e92e593c6ca6d0fc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.347/stella-0.9.347-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "13fc3d2b0529a0ab160e57637652081aca95bfbc544d37ec83eccd59825cf1a2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.347/stella-0.9.347-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cea5215ec62f5509fe4ba2b7efd8006ce7dfb28742ef7a8657b238bcb3b1c944"
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
