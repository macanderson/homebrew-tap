# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.24 / @SHA_*@ placeholders below with
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
  version "0.7.24"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.24/stella-0.7.24-aarch64-apple-darwin.tar.gz"
      sha256 "ca9f4af341aa378fae885afdef07d73140d050fa0fba3f028498d8b15e222cae"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.24/stella-0.7.24-x86_64-apple-darwin.tar.gz"
      sha256 "dc8e04c20cb2cbb49d2bd7b892728306bdfd50f31a01bbf9544bd5953c6cb99d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.24/stella-0.7.24-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "997515d32b317f617599170c68bfa31762ed1ca2d4d3b727d18e93605213499a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.24/stella-0.7.24-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e14e8195d0d4cea3afb5ffb0a812fef6c6c81302cd839709543cf9473304baff"
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
