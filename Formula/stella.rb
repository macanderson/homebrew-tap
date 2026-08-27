# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.257 / @SHA_*@ placeholders below with
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
  version "0.9.257"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.257/stella-0.9.257-aarch64-apple-darwin.tar.gz"
      sha256 "3eebccfaa0e16a454a6ecda973715473b7722daa4dfede770f437d53e3654ca1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.257/stella-0.9.257-x86_64-apple-darwin.tar.gz"
      sha256 "256b8eb99416d540bedcaa92f4d6d083964979a7413e94b601eb7fed044ec03d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.257/stella-0.9.257-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6a65a8afb40baf135fb8edc15a702baa3da77f84cdbfc2d05a2d23eb24a423bd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.257/stella-0.9.257-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "02c11b30a3a30158e6b084567889b835bbda5fc8fd7c29034576404796efe63b"
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
