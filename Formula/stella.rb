# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.146 / @SHA_*@ placeholders below with
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
  version "0.9.146"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.146/stella-0.9.146-aarch64-apple-darwin.tar.gz"
      sha256 "2cfa83ac501376b7a504501743a4e191818adc53725b6cbdb66386147afe9b5d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.146/stella-0.9.146-x86_64-apple-darwin.tar.gz"
      sha256 "e7196ab64ecd0bf02d3717d346375607be0690051f6e1c3193f7b72d4318ae05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.146/stella-0.9.146-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "73afcc6bc91f3fd7adfa65ee34571923df64e3e459e96eba8d52c839e846aa6b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.146/stella-0.9.146-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "560e84cdfbf48fa544775721da8b3275fd51a46110da677acfefc724ba0458c0"
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
