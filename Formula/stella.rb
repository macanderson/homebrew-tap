# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.7 / @SHA_*@ placeholders below with
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
  version "0.6.7"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.7/stella-0.6.7-aarch64-apple-darwin.tar.gz"
      sha256 "43bead5056a16ce1ad091571cdb669295c96516a447093ae06948828e62e9fd8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.7/stella-0.6.7-x86_64-apple-darwin.tar.gz"
      sha256 "f52b9c33e8ffd0a501edadfee9fdccbee796732b38a2dc01813f859802686044"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.7/stella-0.6.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "70d42b089d047a5382cec1c89ea18ab1ba2a511fcdc1599165b6f272c2a39b3b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.7/stella-0.6.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "950ff7758b27257b81839027d767cb54ba9d0319d4ba4d97517985b50017676c"
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
