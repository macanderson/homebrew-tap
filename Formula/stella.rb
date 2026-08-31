# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.302 / @SHA_*@ placeholders below with
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
  version "0.9.302"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.302/stella-0.9.302-aarch64-apple-darwin.tar.gz"
      sha256 "2443322f9c0eb7447b982bae3ac165000735f920fd25950360f0ebced2ff575f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.302/stella-0.9.302-x86_64-apple-darwin.tar.gz"
      sha256 "5f768fd166d3ee3483f00e4ee83155e5ea6954528cd540d331ab42a2757d6165"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.302/stella-0.9.302-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3569dc117b087cba1432d03582c56494190c2652fcf39549537398410a1a4c8e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.302/stella-0.9.302-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bbcf07c3aa983328ff15e8e3cd0d52c738e6b251908fe3b015a133f6f770fa30"
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
