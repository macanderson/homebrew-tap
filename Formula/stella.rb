# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.60 / @SHA_*@ placeholders below with
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
  version "0.5.60"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.60/stella-0.5.60-aarch64-apple-darwin.tar.gz"
      sha256 "a3386bb985aa2582f82cefbf590fefae4b3570ba67cf5ca5b98bf65e943eaa34"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.60/stella-0.5.60-x86_64-apple-darwin.tar.gz"
      sha256 "a6273863ae057eb15bfcba971829d9a75144c00e7f683de079c3878672a18f20"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.60/stella-0.5.60-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1896759cf7ff37768228ca1994a0c36bb77d7e72f030e7dda12f3755104745c3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.60/stella-0.5.60-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3eee24598ad2407579ecf74f88f04abe6f2059d3b9a51f876aeede3d3b8cfed6"
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
