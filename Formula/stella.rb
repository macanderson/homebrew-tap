# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.61 / @SHA_*@ placeholders below with
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
  version "0.6.61"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.61/stella-0.6.61-aarch64-apple-darwin.tar.gz"
      sha256 "e441200e7c96cfda8767b32b322bb7f47418e3d17354505e49e29ccb8ba3b421"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.61/stella-0.6.61-x86_64-apple-darwin.tar.gz"
      sha256 "e34249cefe1aaef985a1347d465748684895455a00ee202a7b0a51c3fa70e490"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.61/stella-0.6.61-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4b9f0efc825ae88c871ec48c4598a11862fdf3a7de13fc6f2fa9b29fe01c701d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.61/stella-0.6.61-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "56a3317079ffb71122f9aec792a9e9235277af2c32bb94905b698eafcedb3b91"
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
