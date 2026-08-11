# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.0 / @SHA_*@ placeholders below with
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
  version "0.9.0"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.0/stella-0.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "7922b5f6c0b64dcb57915ec0647d92e2d0891a03b08435dbbd9f0a297274c893"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.0/stella-0.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "16dd7a36ff07a8fe3099fef85b7d60d5bdb4057e9a1017d2e714ed10d09db98b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.0/stella-0.9.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6b59cb0d666f924f06517c367ac13dd175bed64ec263a6f894df6fa5a493246f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.0/stella-0.9.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8859cce138db859bb4dbf8744c708ae7155acce9b7a5754e143a31888c6ec4ce"
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
