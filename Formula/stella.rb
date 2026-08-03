# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.73 / @SHA_*@ placeholders below with
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
  version "0.6.73"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.73/stella-0.6.73-aarch64-apple-darwin.tar.gz"
      sha256 "ea6600ba8f8fa9dee2bf6cccd5a14d983d04abe0755e66c43007aa0c540784e9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.73/stella-0.6.73-x86_64-apple-darwin.tar.gz"
      sha256 "dc6fbf71d69df1d123e74d70d404f9975a72fa8ab9e25279e2c5f23017e4058a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.73/stella-0.6.73-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "24b11cb8d0c6e9d664b6ebccaa24e8ff9f5e8ebda5a34d9316b661ade2e40e78"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.73/stella-0.6.73-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "27ab1b83113c7b1c383d16a4098529aad1554eca20ba613e01c7b38914fcc579"
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
