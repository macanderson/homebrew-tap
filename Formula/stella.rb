# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.76 / @SHA_*@ placeholders below with
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
  version "0.9.76"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.76/stella-0.9.76-aarch64-apple-darwin.tar.gz"
      sha256 "4214cad9310eaf780c9fc2f78077f12a1d58dc9698df633b513805af61669b2b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.76/stella-0.9.76-x86_64-apple-darwin.tar.gz"
      sha256 "caadb12c1463fc7fe74ed6b98447f58fe92cdf35608a13730fcd5b43fa26d489"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.76/stella-0.9.76-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c41961cd4a21e8db2dfd8fde72718f3af7d8e51165b8297767dbce6b5d37891d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.76/stella-0.9.76-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c86a39ef3a2511da988cbe18ed72f53644aa6479a6198555750b6a4a3f3b775c"
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
