# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.196 / @SHA_*@ placeholders below with
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
  version "0.9.196"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.196/stella-0.9.196-aarch64-apple-darwin.tar.gz"
      sha256 "747cccfcc0145eaf4906c36019daeb11821cb3e3069206b88f22cda5cb85f641"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.196/stella-0.9.196-x86_64-apple-darwin.tar.gz"
      sha256 "76d350a7379d839003aae36a1b697a84d904734b44fbc3d773ba8cbfd79e4206"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.196/stella-0.9.196-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "47c4c85e0ea2111bcbef1b70c29d707bc32d2f724052673f7da36ae5113df51c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.196/stella-0.9.196-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6dbf5dfac1f46f97456489dfe4c20318b0e5ffaad3389f3f54fd9edea5f11030"
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
