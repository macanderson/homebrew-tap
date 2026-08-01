# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.36 / @SHA_*@ placeholders below with
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
  version "0.6.36"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.36/stella-0.6.36-aarch64-apple-darwin.tar.gz"
      sha256 "4ffd453bb8ca3b95d926555902f92d6ef290f05d830b2251b34bd40f65340612"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.36/stella-0.6.36-x86_64-apple-darwin.tar.gz"
      sha256 "88164b3880451b48eddcc2beca1c99eb76d12dae003a45e95aa98197e0ee06bc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.36/stella-0.6.36-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "82b3cd24d56df799493c02ed9b2a08d58349f1f772fd519f0b7ed9661a1b6d66"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.36/stella-0.6.36-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b3348fcbdc21ff8510df99174c898313338b424e46717a298e032dcca2c72834"
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
