# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.70 / @SHA_*@ placeholders below with
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
  version "0.9.70"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.70/stella-0.9.70-aarch64-apple-darwin.tar.gz"
      sha256 "ce2ce2624723abd54a609f949971697c69310febb21c011bb12f2460df81a01c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.70/stella-0.9.70-x86_64-apple-darwin.tar.gz"
      sha256 "f1e7c9f578546ab8ceeaa4d80aa51b6fb8c51378dfbfc5d7e2199fdb6bc714df"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.70/stella-0.9.70-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f0eccd921d47fb2814b726f21ac9c9bebfae491e8ae2bd7207ecfa38dad2e3b8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.70/stella-0.9.70-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cdd60f77b8b75c2eb65fda778b19214c6f08a72c561f1398cea5706e58cd0023"
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
