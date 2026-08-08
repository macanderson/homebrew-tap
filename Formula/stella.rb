# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.20 / @SHA_*@ placeholders below with
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
  version "0.7.20"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.20/stella-0.7.20-aarch64-apple-darwin.tar.gz"
      sha256 "7b07cf506df7655f997cf78298b2cd4335ed1eb7fb7c6cf9343cdc7a2f652050"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.20/stella-0.7.20-x86_64-apple-darwin.tar.gz"
      sha256 "04fc63ba2b4d5233f4165857601288dc56e426f79d0705e661010288fb3bb702"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.20/stella-0.7.20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a86226c47167a94fef7cdb6d77955ec5e12fab57374c9d6920eadf69f87f63c1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.20/stella-0.7.20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fa0176bfe09d15f854a0be1e2c60cb099a521774caa2ff17b5483d7d241a7669"
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
