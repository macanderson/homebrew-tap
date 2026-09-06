# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.376 / @SHA_*@ placeholders below with
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
  version "0.9.376"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.376/stella-0.9.376-aarch64-apple-darwin.tar.gz"
      sha256 "92b70a3bb26bf56a41dade69bc0c32651e2db6079468e55b20fb5e3ca9ac92c3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.376/stella-0.9.376-x86_64-apple-darwin.tar.gz"
      sha256 "b0fe877c36dc08df15a24e9e3944dc6e713906bea99b2f14ddd1ec436aced7d1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.376/stella-0.9.376-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2eb872434eb4b9dbd70d5ffa4c2f2f70f94e3b3c9c9508ccb72a5cfbb13fc108"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.376/stella-0.9.376-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c86e232c700073a6213baad22a1daec8ac8f5ace48482c30d054f87d6323886f"
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
