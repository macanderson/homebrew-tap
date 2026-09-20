# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.429 / @SHA_*@ placeholders below with
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
  version "0.9.429"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.429/stella-0.9.429-aarch64-apple-darwin.tar.gz"
      sha256 "2778ac5f69513264095177b01e1480ff1dfc9f237a102b48a500021bb1363961"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.429/stella-0.9.429-x86_64-apple-darwin.tar.gz"
      sha256 "6ea8846afaee34fa360e7208d1b2e188dea1f72e5bf3befd8a4ef1d972385cdd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.429/stella-0.9.429-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7d0a10a273c3cbefa6d7b151cb7f2536853dfdfde437db11b17e3a8f50d3aff2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.429/stella-0.9.429-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "25d02ae4248a19696252dde47b75671f41144415068df8cfd58a1e95cc7e09d8"
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
