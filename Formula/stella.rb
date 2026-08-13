# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.35 / @SHA_*@ placeholders below with
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
  version "0.9.35"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.35/stella-0.9.35-aarch64-apple-darwin.tar.gz"
      sha256 "c925684a3f0fc2b881ac1a2069d87859bc3f355aa26e57f88df616dc04463425"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.35/stella-0.9.35-x86_64-apple-darwin.tar.gz"
      sha256 "3aab8719c7fceb81a38defd3f0a5605de308ec8b36ba94fd85f3f287e2de1c26"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.35/stella-0.9.35-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "039a60fbba4569c496e83605c150ce977c5605a1cd0b22c782244ea5d04356d0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.35/stella-0.9.35-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c8352f69a23c36db5b920ae4639f0bc2bfa156f5373c008228f8141989ba7f84"
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
