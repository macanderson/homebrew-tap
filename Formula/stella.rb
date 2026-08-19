# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.104 / @SHA_*@ placeholders below with
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
  version "0.9.104"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.104/stella-0.9.104-aarch64-apple-darwin.tar.gz"
      sha256 "650e93d0bff50da0f3661b8e4e629f990cecacca5e36754741d34d082ddd3f00"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.104/stella-0.9.104-x86_64-apple-darwin.tar.gz"
      sha256 "a8f080b3e218762e39e4a7efe84d55fb3889f0b94f62cfc747f63e3e77063447"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.104/stella-0.9.104-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "017ff01eef3ee63078b3ef3b6740a5a95d14e1806fa34f26c2c36d94b39c4041"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.104/stella-0.9.104-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "086ef3a6d9eabc9828c5b74f997d46a2e8c3891adc43547f5a593b60bf69ad3c"
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
