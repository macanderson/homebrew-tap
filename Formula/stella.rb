# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.520 / @SHA_*@ placeholders below with
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
  version "0.9.520"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.520/stella-0.9.520-aarch64-apple-darwin.tar.gz"
      sha256 "3b8e894fe74c5517045f99bf32085a05e98bddf8c8af94826dacc9a7c8ba1856"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.520/stella-0.9.520-x86_64-apple-darwin.tar.gz"
      sha256 "b786f395288da0fa480d9b2cb6e4cf94b921c3c87b7c020b80b2efb451ebed7e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.520/stella-0.9.520-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "815367d6cb245d5d8cc75c3bc77f014302be45111dbe82fc5fc3b85888000aad"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.520/stella-0.9.520-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e66ab12e85cd5923a47a95860da218295012ff968c939896dfc640071fb51ca5"
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
