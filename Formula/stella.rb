# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.141 / @SHA_*@ placeholders below with
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
  version "0.9.141"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.141/stella-0.9.141-aarch64-apple-darwin.tar.gz"
      sha256 "0132b98c5aa0182a5e3d5b2e7f62c73d6aecc3af2a1edcf1a7b609fc90d606e0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.141/stella-0.9.141-x86_64-apple-darwin.tar.gz"
      sha256 "9bdbc3d2a062907366ccdae43af02634d45912d6696b79e9d51690d832e0fc25"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.141/stella-0.9.141-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b55aca0a0a268f872e4a336367c801d1b539acf09e406bdc4f9e483bf76e40af"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.141/stella-0.9.141-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6873aaabea5780a1313d8a2adf15596846348ecf52e7e527d8468bbe2819eb73"
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
