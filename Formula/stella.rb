# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.305 / @SHA_*@ placeholders below with
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
  version "0.9.305"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.305/stella-0.9.305-aarch64-apple-darwin.tar.gz"
      sha256 "37c517560119432c19c88c39a3f4552a5cbd603fb31abfb646eb97258a745bfe"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.305/stella-0.9.305-x86_64-apple-darwin.tar.gz"
      sha256 "e60f63c86b1b1d1656c79aff34f585af6f1adfc4925c0397aefc7585c8112aca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.305/stella-0.9.305-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "af59fa2edb245e0113a83d95b4fa52c2a5f89be823ff90982d28acab8633e984"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.305/stella-0.9.305-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "306bcb83092eebd31cad99336e3bdd2b43bda5f31da00f6b7b0856867c3c8691"
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
