# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.55 / @SHA_*@ placeholders below with
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
  version "0.6.55"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.55/stella-0.6.55-aarch64-apple-darwin.tar.gz"
      sha256 "790e285b5718d56a826a6b94b48c3660f4bb45551cbc5ae5f7a4c4633610445c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.55/stella-0.6.55-x86_64-apple-darwin.tar.gz"
      sha256 "ae6c43998e717695e5f955b20235d181ea06bbd7a8031273391c18d6f9da14c9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.55/stella-0.6.55-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "005cdc0bd2ab29f4b6c1704b1c563fd8031f2efdb5d3ed62a5e3ddbf6f3276d1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.55/stella-0.6.55-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2d765416612519aa004c6fe4ab9601dcfebd6075b320eeea1ca35b1bd2b54f55"
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
