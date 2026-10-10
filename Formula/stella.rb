# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.490 / @SHA_*@ placeholders below with
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
  version "0.9.490"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.490/stella-0.9.490-aarch64-apple-darwin.tar.gz"
      sha256 "08979cee8632334370800f730afc5a2a29a66a55d697c3c20aae204193eb46e5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.490/stella-0.9.490-x86_64-apple-darwin.tar.gz"
      sha256 "0a27e386c85840d8b6e499498d0b64cb70ea4d47ae5a659ee400659a295de3b4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.490/stella-0.9.490-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f6defef18a24f075ab26b30b923b5e2943085f23fe6d8d054a515cca943afc85"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.490/stella-0.9.490-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d6ecd346ce8a6523ec6caddbc1ee2aedd8df8c9d7d22d1c37c284c50e7748b17"
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
