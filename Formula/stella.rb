# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.464 / @SHA_*@ placeholders below with
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
  version "0.9.464"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.464/stella-0.9.464-aarch64-apple-darwin.tar.gz"
      sha256 "d621ff917039ced1cdf3b32c6f048d021cc24361c3e5ebc19ac6e17c04b45860"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.464/stella-0.9.464-x86_64-apple-darwin.tar.gz"
      sha256 "b7b47c40bf220a92e6fe55395b5b32622eb0dd88d9bbb4070daed83bedd67782"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.464/stella-0.9.464-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8e505c69e9270a34d0d60e887789462e7ab050b97f0b071d257c581ba1013984"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.464/stella-0.9.464-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3b7df35dc4fb76ead7d18123fd0f571535cf618a888bf65498919e5adbbabd7b"
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
