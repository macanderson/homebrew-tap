# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.380 / @SHA_*@ placeholders below with
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
  version "0.9.380"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.380/stella-0.9.380-aarch64-apple-darwin.tar.gz"
      sha256 "d7a2b4b9afcb26a57c8efeb6eb9296b8d2c1e9b96afcf6429bd66765f6e81d96"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.380/stella-0.9.380-x86_64-apple-darwin.tar.gz"
      sha256 "e4097253bca7a640feba5b2d2e1ef923ec384900172b5c012fe09a99ab983a6a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.380/stella-0.9.380-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4701470cc861f7920ec665cc2145acc32f8b77402ab1f86825dca1037a4ca811"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.380/stella-0.9.380-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ae5413179867bdb854dbc0b8dc4cdeafd64b026d4c24de0132de0ab639a807ed"
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
