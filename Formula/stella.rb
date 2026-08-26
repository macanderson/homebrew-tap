# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.226 / @SHA_*@ placeholders below with
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
  version "0.9.226"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.226/stella-0.9.226-aarch64-apple-darwin.tar.gz"
      sha256 "84395b0c320459d4a15b94bb17e9a97f8c3ed3c45ae535e1d9185979244bf2a3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.226/stella-0.9.226-x86_64-apple-darwin.tar.gz"
      sha256 "721cb29b18912d20fcddc0d2e48417994e7a4b273e5826ace36cbf0498f53ab0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.226/stella-0.9.226-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6330f1b198eb6b706023bc7fdecfd01e78dad25af4a0caa99f3509f4294c9621"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.226/stella-0.9.226-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "23c30d8ddb47c246b5913b37d005772925df33ce559767121b8d72d1edab1b76"
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
