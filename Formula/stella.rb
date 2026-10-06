# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.484 / @SHA_*@ placeholders below with
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
  version "0.9.484"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.484/stella-0.9.484-aarch64-apple-darwin.tar.gz"
      sha256 "f33f851e4cb817b1e74a9ee9138f4f911e8b36f2fb996e5634995090475593d1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.484/stella-0.9.484-x86_64-apple-darwin.tar.gz"
      sha256 "41eb869491b1a40633ce82522ac4f809649e2aa4b775eb521144b56939ebdda1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.484/stella-0.9.484-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e74926ea76ec3f2352e9c8d88942e806f7dbcfa10e7ab740b1f547881572b469"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.484/stella-0.9.484-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "01834a357d489b742f728e933d7b4dc030812b5cf6cc6382db090631b2ec14c4"
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
