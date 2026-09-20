# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.427 / @SHA_*@ placeholders below with
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
  version "0.9.427"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.427/stella-0.9.427-aarch64-apple-darwin.tar.gz"
      sha256 "deb2d50edbf86d1516dec880d799d16490f642251f0e30f4bb54810b84a831ba"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.427/stella-0.9.427-x86_64-apple-darwin.tar.gz"
      sha256 "d21a8032afd104b148515512e5a1a37c96614c18b0ca09e7e119359400b37eb4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.427/stella-0.9.427-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0c0ee55da2d4486f9dc6fba1c9a215e68c9901abacddaf523300710631a98e3e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.427/stella-0.9.427-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d673068e1ba9643f9955ad787eb9f68d35ed10b4351e38f8f0065bede05dc08e"
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
