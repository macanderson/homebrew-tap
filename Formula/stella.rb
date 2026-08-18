# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.101 / @SHA_*@ placeholders below with
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
  version "0.9.101"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.101/stella-0.9.101-aarch64-apple-darwin.tar.gz"
      sha256 "a38b41f19b20b247e324a877fc9360c0faf21f2594b23e460b0f8f6b5c0cbb9f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.101/stella-0.9.101-x86_64-apple-darwin.tar.gz"
      sha256 "a8374f57d93774b19b6c7ae01fbcc32add10c13d180b6dd8cd2f9f174fa1cb99"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.101/stella-0.9.101-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "989de66452ecf8274d1f8ef947eeffd0e920ab37a0a2047dec70c49065547396"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.101/stella-0.9.101-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5ab54e879fd4e448df55bc64e09af70c5e8849d6d631bdcbfc02db74b3d5f67c"
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
