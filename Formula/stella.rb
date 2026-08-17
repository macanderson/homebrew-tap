# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.78 / @SHA_*@ placeholders below with
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
  version "0.9.78"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.78/stella-0.9.78-aarch64-apple-darwin.tar.gz"
      sha256 "22e3ff964a646d94afa34843e2f3093ad8336f841d50bdcad62f3bd8d7d13632"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.78/stella-0.9.78-x86_64-apple-darwin.tar.gz"
      sha256 "324b14825bfe79a66c07eccd61f6812b0d8fa582239248b0eabaf1589721f2a4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.78/stella-0.9.78-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ffc722773f6174af94c105c4675aacc1346e96231c00314a1f7047110c7a41ca"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.78/stella-0.9.78-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8ef801479ba14f8afd49f0157771da780099f2cc1444c144a84e6f4b4c20af14"
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
