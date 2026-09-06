# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.375 / @SHA_*@ placeholders below with
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
  version "0.9.375"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.375/stella-0.9.375-aarch64-apple-darwin.tar.gz"
      sha256 "911716642a3e2cdf43a3b97ea06ddc76445d407844c630c3a1b19090d4ced60e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.375/stella-0.9.375-x86_64-apple-darwin.tar.gz"
      sha256 "3d8f1918c2c76c589d5b1daec65f9ba36e8081672c9582786527d37d11e5f9ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.375/stella-0.9.375-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0c504908d5d969fa0a11922d97b2988388a1721035f0575f429c441f6c5eb7ae"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.375/stella-0.9.375-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "201967eecffc98f0706fb949ea7fe9936243706af19c697e9385b6440a09c1ec"
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
