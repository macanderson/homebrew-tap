# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.178 / @SHA_*@ placeholders below with
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
  version "0.9.178"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.178/stella-0.9.178-aarch64-apple-darwin.tar.gz"
      sha256 "65ac510f29ee22d770d972db2e245803ccce9172bcad623411e5e05334fb259c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.178/stella-0.9.178-x86_64-apple-darwin.tar.gz"
      sha256 "c6f6058d534663a696f358838e7326e235e09f120173ec871dd564aab7eb2323"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.178/stella-0.9.178-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c807608ea33a7dd27d0f41c6482b37a5389f8f3a711d946c1bc8019e009d8a9e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.178/stella-0.9.178-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eec01a434e7d7fb8322f91dd3751c8e167bbaa27ed1e7e1a28b787b73d5868d8"
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
