# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.31 / @SHA_*@ placeholders below with
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
  version "0.6.31"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.31/stella-0.6.31-aarch64-apple-darwin.tar.gz"
      sha256 "020d1389228d60d444744e2ada6ecc67d942db7eecbb1b06faf8a2f4acf6cca8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.31/stella-0.6.31-x86_64-apple-darwin.tar.gz"
      sha256 "888a4285ee8ccc461a905fd4535eb172751e8899eda694f59f1b9d4486e446a4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.31/stella-0.6.31-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3adf3f6792ab40d5e9b089cdbd1bc044f3bf8cbb835b757471000f5f443252eb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.31/stella-0.6.31-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6392ba98082f793db25fac96638a178a005d2889984102d9f1265bbfa4f5a512"
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
