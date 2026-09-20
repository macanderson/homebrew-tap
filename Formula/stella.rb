# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.426 / @SHA_*@ placeholders below with
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
  version "0.9.426"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.426/stella-0.9.426-aarch64-apple-darwin.tar.gz"
      sha256 "1eaf94567029b510c57ed2d05fa9cd329abcbc4777bd42ae1c7abad7cbaea07a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.426/stella-0.9.426-x86_64-apple-darwin.tar.gz"
      sha256 "cd8662103bb0ea70e3e1a19ea748b35c96c3dddd3c2052db1d796d5332be6374"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.426/stella-0.9.426-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "58c0211445ad1c1b80d54aa8b3dafb06b2dcfd782858c25cf1af5490814b6e4d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.426/stella-0.9.426-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "98950af49ba9e258656b0b3c6c5c8b07075badaff1ef6f45ff79a61c32b6738d"
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
