# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.108 / @SHA_*@ placeholders below with
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
  version "0.9.108"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.108/stella-0.9.108-aarch64-apple-darwin.tar.gz"
      sha256 "89972d2536c949de9610371a6bc4780bbcf780513173ea1765ca11d6f3e6dd6b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.108/stella-0.9.108-x86_64-apple-darwin.tar.gz"
      sha256 "70cadfc7f8d636dcef95eeccda0581edb2b55f33a929a45ff993b8a58daccb6f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.108/stella-0.9.108-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2221aa6ea07aea0d9dcdb5ce5a6755a8754ec1fc600e6324a6c8113328f14cdd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.108/stella-0.9.108-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c1a18dcab3159acca8133257ad702cea44555ac33b5e1a5e22d437cbec489dcc"
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
