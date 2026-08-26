# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.239 / @SHA_*@ placeholders below with
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
  version "0.9.239"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.239/stella-0.9.239-aarch64-apple-darwin.tar.gz"
      sha256 "4d342c8f02b7efb666eb3e35bb283031df983b90034a9b518d7ff0da502816f1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.239/stella-0.9.239-x86_64-apple-darwin.tar.gz"
      sha256 "7f5b008f095ddb7170ff8fa94bb7683be61042db1b27ad57070cc4a0d43bd274"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.239/stella-0.9.239-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "26fbd69c5ab8289ae2fb0565c307b7dc4ee7a76906748a8272e066d9f5462bb4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.239/stella-0.9.239-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "780da1e7becc5c30faf6a51b743b84dbca57603b0144fe1baf779ee5043cc280"
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
