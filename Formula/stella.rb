# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.308 / @SHA_*@ placeholders below with
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
  version "0.9.308"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.308/stella-0.9.308-aarch64-apple-darwin.tar.gz"
      sha256 "39c35fa17ebb3273c2021386a1cd2b326d440ff3d3e3929885076a690c91a322"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.308/stella-0.9.308-x86_64-apple-darwin.tar.gz"
      sha256 "04cc32bb6631cfb78845dc771d0c20b8c1036f58c71712ad44618737527cd657"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.308/stella-0.9.308-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "28a9f01e80755227f29d9052c59d515c359c3ad5cb00a0d8009fa504c822cc64"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.308/stella-0.9.308-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c9b009ae07092c36a1fa0dff4ba305108c5d4be0e7135e0eb857c93b224f35fa"
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
