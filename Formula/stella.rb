# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.35 / @SHA_*@ placeholders below with
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
  version "0.6.35"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.35/stella-0.6.35-aarch64-apple-darwin.tar.gz"
      sha256 "b3aa1ddaaa3c67be54fe8ea63e12c3258f4d149141610b1018fa773d3542c52b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.35/stella-0.6.35-x86_64-apple-darwin.tar.gz"
      sha256 "753d75c7e4ee6cfd3dd860ec2516ce05fb51914f204ceb40ec247dc67c15a56c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.35/stella-0.6.35-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "30643130fdb5b7741481421f1ba8d0b74882fa8419a46257dd0e9fed38bb0273"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.35/stella-0.6.35-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7bfba01b8e30b36440c0831a126889bcb3714696aff81aceeb7d509796f2ca29"
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
