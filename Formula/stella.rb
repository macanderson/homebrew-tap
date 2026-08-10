# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.25 / @SHA_*@ placeholders below with
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
  version "0.8.25"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.25/stella-0.8.25-aarch64-apple-darwin.tar.gz"
      sha256 "e8a94e92fd4111936e103d318e179174d65350b8bbff893c9150e8d34f0a715e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.25/stella-0.8.25-x86_64-apple-darwin.tar.gz"
      sha256 "0a3c426594df1bb4ecbfe7a3afcdb9a76940419b9256cf06d3c919220f79429b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.25/stella-0.8.25-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "77384ff4d7b9522497209feacd03b2031d03815de936979d810bae2fdfa18014"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.25/stella-0.8.25-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1f812b62eac62fd847ee8b9df889198148a5d997eb61161279e0d1ff3753b570"
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
