# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.248 / @SHA_*@ placeholders below with
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
  version "0.9.248"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.248/stella-0.9.248-aarch64-apple-darwin.tar.gz"
      sha256 "30c20086bca3b6cb5b006a7eb85eae0bd42b2328d2331ee1758305628806bc04"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.248/stella-0.9.248-x86_64-apple-darwin.tar.gz"
      sha256 "0943e92757a0f28e323bbbdf3acca8353c648687483cc8d6df0c86bcd10a00cb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.248/stella-0.9.248-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "590c0c711af9ffb97c5d010d017799e6b384f6cfe7cd4031d340db82ae781f88"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.248/stella-0.9.248-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2a7f828fdd9a7bcab01eecd9b47e171f55a0ef31eedef2195cf6f9057273febb"
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
