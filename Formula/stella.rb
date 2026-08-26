# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.233 / @SHA_*@ placeholders below with
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
  version "0.9.233"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.233/stella-0.9.233-aarch64-apple-darwin.tar.gz"
      sha256 "9e20b1b2af1928d092f2a9829d7e32eb9e66b161f6d5281c48ccb63ca1b2b1c2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.233/stella-0.9.233-x86_64-apple-darwin.tar.gz"
      sha256 "681dd4eb7fa95034642a4defb432e07098c7bffe7b48bdd559bf0958a0d28219"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.233/stella-0.9.233-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f24f8efa42ac1be840a16624cc1d9127b4d48eb72e92094ae3799e6b88826898"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.233/stella-0.9.233-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "319b42e1de1a29d48265957dc17e4815f02478a24034d24b0a1ab8f1aed2f141"
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
