# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.276 / @SHA_*@ placeholders below with
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
  version "0.9.276"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.276/stella-0.9.276-aarch64-apple-darwin.tar.gz"
      sha256 "f2d782704a51dc5274e83645b69a518404ce800e9bf32d863562f1c71fd67550"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.276/stella-0.9.276-x86_64-apple-darwin.tar.gz"
      sha256 "190e0b2079a5703951281b83564bc91c4ebdb585e7e0757edf9ca5fab037878a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.276/stella-0.9.276-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "26938729c9404d778890fd4566be53418ff841ab8c655c6227c7182bc257aec4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.276/stella-0.9.276-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "39ee8d007cfae82410aa2dbc13041fff84077a740096854576d0180ca4368c0a"
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
