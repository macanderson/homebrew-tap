# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.161 / @SHA_*@ placeholders below with
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
  version "0.9.161"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.161/stella-0.9.161-aarch64-apple-darwin.tar.gz"
      sha256 "6697cb28f1afa514f9e879581ed05bb1bc3dc23750d72b6962fd68c703738fc3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.161/stella-0.9.161-x86_64-apple-darwin.tar.gz"
      sha256 "1b6bf81e68c9dec10576d684ffe7ed9ff9e517b78a7ecf88a5094eea34c63d1c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.161/stella-0.9.161-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "04f94eeba57761b1260d23796d0923fdb512923c3c3f3991b0b0decae0408d39"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.161/stella-0.9.161-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7f25da4c213c3b4d980fefbb373d06fe4ce261765c90f2e21e847939c396cc41"
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
