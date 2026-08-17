# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.79 / @SHA_*@ placeholders below with
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
  version "0.9.79"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.79/stella-0.9.79-aarch64-apple-darwin.tar.gz"
      sha256 "fdedf21a8b25aa295e7c2de29e4f310cb5cc6739df8ea905549112f3897878b8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.79/stella-0.9.79-x86_64-apple-darwin.tar.gz"
      sha256 "2134a4e1b8c722406f3b6f82ba9367e440993a3ecad98e02af5ac0c44e762f54"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.79/stella-0.9.79-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "577643086e42c8aba8251361a520046a93a204dc8b61f66ecf2ecfa7276812f2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.79/stella-0.9.79-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f6fc44bab6f554d316088c0aba79163ab2394414e7ebc560db3dc13111dcbdf8"
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
