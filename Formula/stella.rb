# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.27 / @SHA_*@ placeholders below with
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
  version "0.5.27"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.27/stella-0.5.27-aarch64-apple-darwin.tar.gz"
      sha256 "e95b036e56629cac237540a6be964e985ae28a27185026c142a470576f7efd42"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.27/stella-0.5.27-x86_64-apple-darwin.tar.gz"
      sha256 "4810ca150bc468e14ca4e643d809b7aa108530a7ccf477a6a602db71a1a84d77"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.27/stella-0.5.27-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f82a95b19d52446b354f250a413f562ae6e3d234df2fbf3f735c971deb5c67a1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.27/stella-0.5.27-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6c5756a25291ea0232c68621a1cb3af882c12ff0a46f128e7d61ce32dbac4a35"
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
