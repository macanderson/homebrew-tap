# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.186 / @SHA_*@ placeholders below with
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
  version "0.9.186"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.186/stella-0.9.186-aarch64-apple-darwin.tar.gz"
      sha256 "9ab1f4ba9cd0e1be756186176c84fde1000c201149edcd63117e428746d9547d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.186/stella-0.9.186-x86_64-apple-darwin.tar.gz"
      sha256 "78c38504467b4ef2a9b80509f65e72631d80c85ea496e64c1e0b77f8de1c8550"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.186/stella-0.9.186-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d12380d9f68135b909d672d922cd629026da0d4975f986b144887d712a321a7c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.186/stella-0.9.186-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "618abc3cac8031bafbcd7c49cff93ba4efcee6e729ba1bab40457fc10187c038"
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
