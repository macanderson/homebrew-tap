# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.74 / @SHA_*@ placeholders below with
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
  version "0.6.74"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.74/stella-0.6.74-aarch64-apple-darwin.tar.gz"
      sha256 "716435c919461741f710bc737fb7d1b60906981342ecdb5402ab2228028cd2bc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.74/stella-0.6.74-x86_64-apple-darwin.tar.gz"
      sha256 "accbb7b23b1cbf97c1deec4bab12ea210b7093a2c3a4d2fb43835b4093e389f0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.74/stella-0.6.74-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2b99afce060b8e24ecb40cbbef428c92242b330f3c1cedcc4e5a40c130bd7903"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.74/stella-0.6.74-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1154f117bd0f48f1f30de70e7101181dfbea1522ee25fbe45feb62e7521cdfc2"
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
