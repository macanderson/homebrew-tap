# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.140 / @SHA_*@ placeholders below with
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
  version "0.9.140"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.140/stella-0.9.140-aarch64-apple-darwin.tar.gz"
      sha256 "e49e5789b4dc61cf759ea46c32f2664f542547a5429442dc2bdd92ec56d074c3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.140/stella-0.9.140-x86_64-apple-darwin.tar.gz"
      sha256 "5d32c968e9b258e15dda2b53aecfca27708f14b80be40066a05e39ae350491b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.140/stella-0.9.140-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "859e29705bc67c086a6d74469ff5b77fb964cdf06b0bfc647fb1de86481e2246"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.140/stella-0.9.140-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "487312c4bc4e7254cab268ff74953f854964b1d02cfef6f472b7314efc897b23"
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
