# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.185 / @SHA_*@ placeholders below with
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
  version "0.9.185"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.185/stella-0.9.185-aarch64-apple-darwin.tar.gz"
      sha256 "a9af860a41039a2a3daad999d2118e28c0a8faa133eda1d35d2f01e0f43dc4dc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.185/stella-0.9.185-x86_64-apple-darwin.tar.gz"
      sha256 "80c85c39c3417831bab5f2d9b754991089483a0c53e3610f83e2fce5c234864a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.185/stella-0.9.185-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d2e3a085a541d197767455e9b772b5a8407800c0a35c402eaeb78af09dbe13e5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.185/stella-0.9.185-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "09cbdfbf8e06f4508b2bccfe5143eebf62ae466ae717fe5be8f3d725d481f388"
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
