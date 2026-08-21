# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.124 / @SHA_*@ placeholders below with
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
  version "0.9.124"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.124/stella-0.9.124-aarch64-apple-darwin.tar.gz"
      sha256 "44e5c0fba1bbbb151fc191099501c0ab6e939b7417eddb423ebfe06bbc07a04a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.124/stella-0.9.124-x86_64-apple-darwin.tar.gz"
      sha256 "ba27e71ebf7a182f81caed0e3b180c6718a02b2245cbe160dc2c2b6b4b23f11e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.124/stella-0.9.124-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "16fe82eb4c09411109b62ea8cd5a98afb1fcc7ed3a9c023b60a21c94a77a662c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.124/stella-0.9.124-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1088ef19adcb602921585fe148f8d4438302252f32b61bd26d6f873dd953d014"
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
