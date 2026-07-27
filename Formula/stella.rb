# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.61 / @SHA_*@ placeholders below with
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
  version "0.5.61"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.61/stella-0.5.61-aarch64-apple-darwin.tar.gz"
      sha256 "9f64e3aaf21ccf1c861f4b55025ea2e87ae599afd0f8ab3ad2a41023fef687e6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.61/stella-0.5.61-x86_64-apple-darwin.tar.gz"
      sha256 "6abd7e74a8464603f70da6c13a4a94fd5b05b705b83594ea0fbc096f842594c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.61/stella-0.5.61-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cf1818d061dac5e3fe903631b823f65480b441573f579e8e307f68ef85a8ee09"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.61/stella-0.5.61-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "869c889e18c17d0c2fb239bcd60c8f1af37bd79626bfe4aafa3eeb3cca113930"
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
