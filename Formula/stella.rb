# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.310 / @SHA_*@ placeholders below with
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
  version "0.9.310"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.310/stella-0.9.310-aarch64-apple-darwin.tar.gz"
      sha256 "070f15ca4912fd4a5daadb40eda25d6c6e785126ff0c3e803ba4602698f4baae"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.310/stella-0.9.310-x86_64-apple-darwin.tar.gz"
      sha256 "bd2a69b93eb2bdca30977bcf39bb0ebcbe55345c58bc56ec5575d60d4d693328"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.310/stella-0.9.310-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "737f3bc6ec05e0638019ae00605e1814bf1912bd19b53a815b04105eb5262929"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.310/stella-0.9.310-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "365fe338c33f30caf999f272ead19b8769f33a8496165129d248385c9bb72e98"
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
