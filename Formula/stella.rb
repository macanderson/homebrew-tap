# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.203 / @SHA_*@ placeholders below with
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
  version "0.9.203"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.203/stella-0.9.203-aarch64-apple-darwin.tar.gz"
      sha256 "be6c38624966b0485d1fccd8104a1825c808df13d2d908f455be126bcce6a870"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.203/stella-0.9.203-x86_64-apple-darwin.tar.gz"
      sha256 "4f8d34d1badb313e23f71d616a4b546773ef176df5cfa5ecd3450ececa123f43"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.203/stella-0.9.203-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ac02358f7fe5aa991d2f01e039a8f6ea5a959893cec64f5a4aebea9d83c0f5ce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.203/stella-0.9.203-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7eba23362931cd6b01f505383e977d08a4f8714c2074045f52db47ecaaa863fa"
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
