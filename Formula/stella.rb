# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.237 / @SHA_*@ placeholders below with
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
  version "0.9.237"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.237/stella-0.9.237-aarch64-apple-darwin.tar.gz"
      sha256 "a5d5b7b40f7bacbff29121f9cac303c28179a0a6c430ca68abcc31d847252d55"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.237/stella-0.9.237-x86_64-apple-darwin.tar.gz"
      sha256 "9d628f3aa276e435a8ab4a1f307f347561331464d8da962f451a30890dc6f5f6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.237/stella-0.9.237-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8d33abf65be1de56498e966d747999d6f10dad52e8a33b9a55c29240b9d2b2e3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.237/stella-0.9.237-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "679643a66dfe0cb2f33a2da1c18b248ab219d9e71b4bd12c15b2d0290e9014fd"
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
