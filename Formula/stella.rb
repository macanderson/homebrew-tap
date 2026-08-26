# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.232 / @SHA_*@ placeholders below with
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
  version "0.9.232"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.232/stella-0.9.232-aarch64-apple-darwin.tar.gz"
      sha256 "a6041ba676aa9d6f84383c905720be6e68ba29f3fc35ade886f41e2a6e4b261c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.232/stella-0.9.232-x86_64-apple-darwin.tar.gz"
      sha256 "7864fbc918460b6075926654e5cb711b7f1fd127f53ba760159b3764542b56c9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.232/stella-0.9.232-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "947986262f29a9a60366fe3681ce227d88243f3a11fa91869121d2f9bc191c86"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.232/stella-0.9.232-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6202ee2cc592627c9a5a44ee744312179155f50d47c2c410624693fd6b89d6f9"
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
