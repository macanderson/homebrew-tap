# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.408 / @SHA_*@ placeholders below with
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
  version "0.9.408"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.408/stella-0.9.408-aarch64-apple-darwin.tar.gz"
      sha256 "2b35af9b5ca73dda4c0acd936135c407cc2674003569995cc615d856122b21ae"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.408/stella-0.9.408-x86_64-apple-darwin.tar.gz"
      sha256 "08cc22d67a0f69152b51f85f63b9016f9387ed5bcddbb45df0af0d4d6f20011c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.408/stella-0.9.408-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "239eaee25a2b34f96cfbcef5ac4824a97e76522d7c449216fba6821dd37085f8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.408/stella-0.9.408-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ae4603caa628fa26423b92f0cf428bca075df2a60d20aa9f0cdadea2f8b817bf"
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
