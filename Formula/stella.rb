# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.59 / @SHA_*@ placeholders below with
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
  version "0.6.59"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.59/stella-0.6.59-aarch64-apple-darwin.tar.gz"
      sha256 "b6393e03a7a6230163588ed3cbc45408363dd169fdd35c6c6d5060218c72230b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.59/stella-0.6.59-x86_64-apple-darwin.tar.gz"
      sha256 "6d48d6704ec1cc58e367840fa585f14d7682deb05e8d0d83185eeff7ae024356"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.59/stella-0.6.59-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b0f57b45fdc4587af33e1756a6abdbfd9c0a7ccd009160fd71307c84ff3676fd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.59/stella-0.6.59-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "be2f29ce430e0033c6e0249b041f150242cc8dac7177f1a6a7e83ad334074f7f"
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
