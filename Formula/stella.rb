# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.452 / @SHA_*@ placeholders below with
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
  version "0.9.452"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.452/stella-0.9.452-aarch64-apple-darwin.tar.gz"
      sha256 "812db7402f1291d0a18129588d78447c523dcf7e3ea19d02ff4b0dad145218b3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.452/stella-0.9.452-x86_64-apple-darwin.tar.gz"
      sha256 "d159eb8912656b8b0a53f05cfa366b85dfc327548aa2d7e3e9b8cb0268648a50"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.452/stella-0.9.452-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b05bde87c65acc9a94a064d06f18ede050d02035c77e5df10aa3df3b63baf58b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.452/stella-0.9.452-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2e035782d9c574b434c11d44b29e5c722b8b150331ff3985c1c3ac0c9f849aee"
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
