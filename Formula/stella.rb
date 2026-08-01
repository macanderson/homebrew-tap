# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.51 / @SHA_*@ placeholders below with
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
  version "0.6.51"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.51/stella-0.6.51-aarch64-apple-darwin.tar.gz"
      sha256 "548d03a1c3715e10ed4f292066a6e2447b58b4e222d9e2397023df6934c394d1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.51/stella-0.6.51-x86_64-apple-darwin.tar.gz"
      sha256 "c203fa45f3fa5bf6560e49c62cd530705bfb01e8f9fc9299deb9699b89f08928"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.51/stella-0.6.51-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "673149711a36501f1f845abb7813cc60da44dcceb9096b96f04c966ac1b9734c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.51/stella-0.6.51-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6c3cbbe521af96af83de00418dec749192b1c248d92299d378947d512525383d"
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
