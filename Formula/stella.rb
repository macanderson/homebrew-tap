# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.411 / @SHA_*@ placeholders below with
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
  version "0.9.411"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.411/stella-0.9.411-aarch64-apple-darwin.tar.gz"
      sha256 "111df9a3e3f7684336b35ecbbf612df0d9a0e775f6da814ae8f8a7cb823836fe"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.411/stella-0.9.411-x86_64-apple-darwin.tar.gz"
      sha256 "2fb9d88237ed74b76a31cd0e17a3a1af661b9032391ea5530693af7ffa769c00"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.411/stella-0.9.411-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f2ec191fac597fdd9fa8fbf0430a300e90b756aed4cec9db41795a2d0c8ae3ff"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.411/stella-0.9.411-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ac06dfea5732da44712f2cefcbeeebc8d1af6a141970bbf31588560fab88b629"
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
