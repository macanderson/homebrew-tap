# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.476 / @SHA_*@ placeholders below with
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
  version "0.9.476"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.476/stella-0.9.476-aarch64-apple-darwin.tar.gz"
      sha256 "4df783f12513ae00467accc2cdadfd81cbae1f8fcb893262b8421f92d8b22329"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.476/stella-0.9.476-x86_64-apple-darwin.tar.gz"
      sha256 "832f085aaaf46ed54432cd45c209a851a0ae5372a3f86a094de42fbeeadec960"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.476/stella-0.9.476-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a3bce9a85c794f8eea5e928715ec63015ed5fa547d01d8f786334847ab94afa7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.476/stella-0.9.476-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "016307a54cfd4b15edfa603af01d30e9b73edbec39d76a843293585ece466155"
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
