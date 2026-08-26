# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.231 / @SHA_*@ placeholders below with
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
  version "0.9.231"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.231/stella-0.9.231-aarch64-apple-darwin.tar.gz"
      sha256 "8fa9135b3f5ad6c386c4dfd67f9a1e842ce27707ca6f09ff2646210d1ecb92be"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.231/stella-0.9.231-x86_64-apple-darwin.tar.gz"
      sha256 "941ff04d8da0b59f46419740998252895b1eb529cc313689d81e28c2b0413668"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.231/stella-0.9.231-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "735ccae1a742832017ae3c1e844faf5cad973445b99516ee5d4a35593d734a5e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.231/stella-0.9.231-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4289ab047e5e36bf35613155df559c2f11280004740b6799c8cfe69e3b91bc1e"
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
