# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.52 / @SHA_*@ placeholders below with
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
  version "0.6.52"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.52/stella-0.6.52-aarch64-apple-darwin.tar.gz"
      sha256 "69ef8d7a1ce0f2a5d00bb86f92b9e18fdaa655c15851a03c0f7a35b2f38f02d8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.52/stella-0.6.52-x86_64-apple-darwin.tar.gz"
      sha256 "35cfdb3b96977d11a4ca9d21928894a55e612c7ac3ea4947ce1d070b3de2840c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.52/stella-0.6.52-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b6dd25b0101486379e647c6331650ccc0736ed4ad44f64020afe1775a351682a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.52/stella-0.6.52-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "269be92037d264f09048c43171828bc5e74910e62885155a1bb6af9796a29af0"
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
