# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.26 / @SHA_*@ placeholders below with
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
  version "0.7.26"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.26/stella-0.7.26-aarch64-apple-darwin.tar.gz"
      sha256 "b46f84272799aef5f6efd1c2efebb6b81285ba45b4a0ad3d5e0ad005f4f34d5b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.26/stella-0.7.26-x86_64-apple-darwin.tar.gz"
      sha256 "bd87ef6f1794e45a844954415410fed4520483eccc0f36117555e9026de0e47c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.26/stella-0.7.26-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e459bef2f34a56b5beb57d831f5730023becd2f1d7eb8c3db5f770c6e38d2fab"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.26/stella-0.7.26-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fd2b6f2481bc89994ce1ec5ada0cb28c2b99611c515875958a4a054de65e2470"
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
