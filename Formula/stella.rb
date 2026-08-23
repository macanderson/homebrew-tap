# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.144 / @SHA_*@ placeholders below with
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
  version "0.9.144"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.144/stella-0.9.144-aarch64-apple-darwin.tar.gz"
      sha256 "8f6b833bb6e19e2f3f34b99cda5f649ce80cfdb29ac9547eadd3106a40226db3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.144/stella-0.9.144-x86_64-apple-darwin.tar.gz"
      sha256 "e9515aebee0207fca93b4700f764ccc8b3d1f3f49ee261c70047264e213d8ad2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.144/stella-0.9.144-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ba0fad83ab7d054ea3781c56641aadcecc502e608b310c809a646836b03be92d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.144/stella-0.9.144-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a7dd3b4a1d619045f4cf466b2ffa66d4e12911df4044339ee4167568d48c1498"
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
