# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.84 / @SHA_*@ placeholders below with
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
  version "0.9.84"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.84/stella-0.9.84-aarch64-apple-darwin.tar.gz"
      sha256 "64f861810bac875219c4e18936b653327b95cdda6aa2dbb78762223c70cde676"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.84/stella-0.9.84-x86_64-apple-darwin.tar.gz"
      sha256 "105ba7efc189a8ee8baec480529edf27ddc53477366c7e6edcaea5a310260471"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.84/stella-0.9.84-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2f4e2ee04966f09a19eeec3912094243a4c9432f0ab168b89abe280f74d4721c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.84/stella-0.9.84-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "02013007144e6b35d1dd3300f9b750556f4d116fee8a82871a50b5e8692cca1a"
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
