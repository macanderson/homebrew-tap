# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.198 / @SHA_*@ placeholders below with
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
  version "0.9.198"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.198/stella-0.9.198-aarch64-apple-darwin.tar.gz"
      sha256 "1349834192e85c877bf22c4e5f95aa9908ba37ea1e012b04ca595459d663873e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.198/stella-0.9.198-x86_64-apple-darwin.tar.gz"
      sha256 "4185f449ad045bb6827db91770bcd0c424ea76feb774445a1b06dceb38f5fed6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.198/stella-0.9.198-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a17a018f20242c368de41a8d918048a107bcb7f5473ccb14e00a15c8d0516f22"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.198/stella-0.9.198-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "24bae594272104eb71a2678afa6c7396d5c0897038cc3bacf6a97bb15d897301"
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
