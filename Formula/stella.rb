# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.17 / @SHA_*@ placeholders below with
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
  version "0.9.17"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.17/stella-0.9.17-aarch64-apple-darwin.tar.gz"
      sha256 "9d6390895a08a5a7ad5f4406d004af2b02362099471fbcf02434aea88b59d9cd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.17/stella-0.9.17-x86_64-apple-darwin.tar.gz"
      sha256 "ded48d2a2be404ae95f9f6a480c2c369dd55d7e66fe3c3eb372203cd2984d6ba"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.17/stella-0.9.17-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aa7f9f617e164287fc9df2d2726ce9eaaf2b34bd50dd6edca2e23352f678b840"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.17/stella-0.9.17-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9801fe9503ac2bb0ca4dd02d04d68be58e0bb51fd99f0119a4a3fdd145e3bca7"
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
