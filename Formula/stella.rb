# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.9 / @SHA_*@ placeholders below with
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
  version "0.9.9"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.9/stella-0.9.9-aarch64-apple-darwin.tar.gz"
      sha256 "e30ca933696fedd0fb8ceb819948ff18303046ebb8a51e172f8787a0967481c7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.9/stella-0.9.9-x86_64-apple-darwin.tar.gz"
      sha256 "8616c492e7f6c6d8ba550f17d2249bc281fbc70ece99771ead1d3ba7e7b38b05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.9/stella-0.9.9-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e5db7fd906c6d309801edd4bbd62fb24ff3775c0d33676d4a267392174ed8fca"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.9/stella-0.9.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "da61f53e45db8c45cfcdd0dcfb32a08cee6025b94b67dd08d0cc6205a46b927c"
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
