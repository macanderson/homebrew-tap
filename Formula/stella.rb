# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.391 / @SHA_*@ placeholders below with
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
  version "0.9.391"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.391/stella-0.9.391-aarch64-apple-darwin.tar.gz"
      sha256 "3f1b88658877f4c116452946c02900f1a5ac00d5ec4b42a4ad2a2a8c8aa55059"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.391/stella-0.9.391-x86_64-apple-darwin.tar.gz"
      sha256 "010576425862beccb363a4839b20de3fdae4311ba07d85dacc17d7a21dc20562"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.391/stella-0.9.391-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "208b254a8ce7b96482323c403fe0c27561fe380ca7cee30b3c5b6a59cb5117b9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.391/stella-0.9.391-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0ccebf9effdffa3f6ac673a6f88c593676bdf5bf2c3188f17f64c5fc18fe43a2"
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
