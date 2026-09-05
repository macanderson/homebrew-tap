# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.335 / @SHA_*@ placeholders below with
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
  version "0.9.335"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.335/stella-0.9.335-aarch64-apple-darwin.tar.gz"
      sha256 "935079a5b36cc6894ce9452a79a6163d24183d9d275edcda30535767ca4de1ae"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.335/stella-0.9.335-x86_64-apple-darwin.tar.gz"
      sha256 "48760fb6baa0d34aa3d9a8c249399403645dcc7eab5e323c3666aee969266f18"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.335/stella-0.9.335-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "037ead787e0c2669eb7694d56cd2edd2c6fd6d9b527d2c52cb7678c2622a8a63"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.335/stella-0.9.335-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b7ca18706bcca5bb05a3bd1a405dae3097dc7b84ca623b7c34d0966ff1b2c3de"
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
